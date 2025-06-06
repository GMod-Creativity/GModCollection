local ltw = LocalToWorld
local ti = table.insert
local tn = tonumber
local clamp = math.Clamp
local iv = IsValid

local chat_color = Color( 155, 255, 0 )
local chat_color_confirm = Color( 255, 55, 55 )
local ent_color_child = Color( 155, 255, 0, 155 )
local ent_color_parent = Color( 255, 155, 0, 155 )
local button_back_color = Color( 52, 52, 52, 255 )
local button_back_color_hover = Color( 72, 72, 72, 255 )
local button_back_color_clicked = Color( 62, 62, 62, 255 )
local button_text_color = Color( 245, 245, 245, 255 )
local button_text_color_hover = Color( 255, 255, 205, 255 )
local button_text_color_clicked = Color( 245, 225, 225, 255 )
local button_green_color = Color( 139, 186, 99, 255 )
local button_red_color = Color( 186, 99, 69, 255 )
local button_blue_color = Color( 55, 139, 186, 255 )

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Constraints"
TOOL.Name = "Rope Mass Center"
TOOL.Command = nil
TOOL.ConfigName = nil

if CLIENT then -- add language strings
	
	-- help strings
	language.Add( "tool.ropemasscenter.name", "Rope Mass Center" )
	language.Add( "tool.ropemasscenter.desc", "Create ropes directly between entities' centers of mass." )
	language.Add( "tool.ropemasscenter.help", "This is a modified rope tool that will rope between the mass centers of selected entities instead of trace hitpoints. If you're using the offsets, it's recommended that you freeze whatever you're roping together first." )
	language.Add( "tool.ropemasscenter.left", "Start roping between mass centers" )
	language.Add( "tool.ropemasscenter.right", "Add a new segment between mass centers" )
	language.Add( "tool.ropemasscenter.left_1", "Finish roping between mass centers" )
	language.Add( "tool.ropemasscenter.reload", "Clear all rope constraints (including those created with the normal rope tool)" )
	
	-- control panel
	language.Add( "tool.ropemasscenter.offseta", "First point offset:" )
	language.Add( "tool.ropemasscenter.offsetb", "Second point offset:" )
	language.Add( "tool.ropemasscenter.offseta.help", "Negative values will attach the rope at a point further past the center of mass on the first prop; positive values will move the attachment point in, towards the second point." )
	language.Add( "tool.ropemasscenter.offsetb.help", "Negative values will attach the rope at a point further past the center of mass on the second prop; positive values will move the attachment point in, towards the first point." )
	language.Add( "tool.ropemasscenter.offsetc", "Vertical offset:" )
	language.Add( "tool.ropemasscenter.offsetc.help", "Absolute vertical offset for both points on world z. Negative values for down, positive for up." )
	language.Add( "tool.ropemasscenter.width", "Thickness: " )
	language.Add( "tool.ropemasscenter.addlength", "Add length: " )
	language.Add( "tool.ropemasscenter.forcelimit", "Force limit: " )
	language.Add( "tool.ropemasscenter.forcelimit.help", "If the rope experiences any amount of force greater than the force limit, it will break. Set the force limit to 0 to have the rope never break." )
	
	-- presets
	language.Add( "tool.ropemasscenter.preset_couple", "The Perfect Couple" )
	language.Add( "tool.ropemasscenter.preset_bmw", "BMW" )
	
end

if SERVER then

	util.AddNetworkString( "tylarstools_ropemasscenter_tooshort" )

end

TOOL.ClientConVar[ "forcelimit" ] = "0"
TOOL.ClientConVar[ "addlength" ] = "0"
TOOL.ClientConVar[ "material" ] = "cable/cable"
TOOL.ClientConVar[ "width" ] = "1.5"
TOOL.ClientConVar[ "rigid" ] = "1"
TOOL.ClientConVar[ "firstoffset" ] = "0"
TOOL.ClientConVar[ "secondoffset" ] = "0"
TOOL.ClientConVar[ "verticaloffset" ] = "0"

TOOL.Information = {
	{ name = "left", stage = 0 },
	{ name = "left_1", stage = 1 },
	{ name = "right", stage = 1 },
	{ name = "reload" }
}

function TOOL:LeftClick( trace )
	
	local isv = iv( trace.Entity )
	if ( isv and trace.Entity:IsPlayer() ) or ( not isv ) then return end
	
	if SERVER and ( not tylarstools.cantarget( self:GetOwner(), trace.Entity ) ) then return false end
	
	-- If there's no physics object then we can't constraint it!
	if ( SERVER and not ( util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) ) then return false end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then

		if ( CLIENT ) then

			self:ClearObjects()
			return true

		end

		-- Get client's CVars
		local forcelimit = clamp( self:GetClientNumber( "forcelimit" ), 0, 1000 )
		local addlength = clamp( self:GetClientNumber( "addlength" ), -500, 500 )
		local material = self:GetClientInfo( "material" )
		local width = clamp( self:GetClientNumber( "width" ), 0, 10 )
		local fo = clamp( self:GetClientNumber( "firstoffset" ), -500, 500 )
		local so = clamp( self:GetClientNumber( "secondoffset" ), -500, 500 )
		local vo = clamp( self:GetClientNumber( "verticaloffset" ), -500, 500 )
		local rigid = self:GetClientNumber( "rigid" ) == 1

		-- Get info
		local Ent1, Ent2 = self:GetEnt( 1 ), self:GetEnt( 2 )
		local Bone1, Bone2 = self:GetBone( 1 ), self:GetBone( 2 )
		local Phys1, Phys2 = self:GetPhys( 1 ), self:GetPhys( 2 )
		local Mc1 = Phys1:GetMassCenter()
		local Mc2 = Phys2:GetMassCenter()
		local WPos1, WPos2 = Phys1:LocalToWorld( Mc1 ), Phys2:LocalToWorld( Mc2 )
		local length = ( WPos1 - WPos2 ):Length()
		local atoba = Phys1:WorldToLocal( WPos2 ):Angle()
		local btoaa = Phys2:WorldToLocal( WPos1 ):Angle()
		if ( not ( fo == 0 ) ) or ( not ( so == 0 ) ) then
		
			if fo + so > length then
				
				net.Start( "tylarstools_ropemasscenter_tooshort" )
				net.Send( self:GetOwner() )
				fo = 0
				so = 0
			
			end
			
		end
		
		length = length - so - fo
		local absvec = Vector( 0, 0, vo )
		
		-- create the rope
		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, Mc1 + ( atoba:Forward() * fo ) + absvec, Mc2 + ( btoaa:Forward() * so ) + absvec, length, addlength, forcelimit, width, material, rigid )

		-- Clear the objects so we're ready to go again
		self:ClearObjects()

		-- Add The constraint to the players undo table

		undo.Create( "Rope Mass Center (" .. string.StripExtension( string.GetFileFromFilename( Ent1:GetModel() ) ) .. " " .. Ent1:EntIndex() .. " - " .. string.StripExtension( string.GetFileFromFilename( Ent2:GetModel() ) ) .. " " .. Ent2:EntIndex() .. ")" )
			undo.AddEntity( constraint )
			undo.AddEntity( rope )
			undo.SetPlayer( self:GetOwner() )
			undo.SetCustomUndoText( "Undone Rope Mass Center" )
		undo.Finish()

		self:GetOwner():AddCleanup( "ropeconstraints", constraint )
		self:GetOwner():AddCleanup( "ropeconstraints", rope )

	else

		self:SetStage( iNum + 1 )

	end

	return true

end

-- net receive
if CLIENT then

	net.Receive( "tylarstools_ropemasscenter_tooshort", function( len )

		notification.AddLegacy( "Sum of 1st and 2nd offsets exceeds length, attaching at midpoint", NOTIFY_ERROR, 6 )

	end )

end

hook.Add( "OnUndo", "Tylarstools_OnUndo_RopeMassCenter", function( name, customtext )

	if name:sub( 1, 16 ) == "Rope Mass Center" then
	
		MsgN( "Undone " .. name )
	
	end

end )

function TOOL:RightClick( trace )
	
	local isv = iv( trace.Entity )
	if ( isv and trace.Entity:IsPlayer() ) or ( not isv ) then return end
	
	if SERVER and ( not tylarstools.cantarget( self:GetOwner(), trace.Entity ) ) then return false end
	
	-- If there's no physics object then we can't constraint it!
	if ( SERVER and not ( util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) ) then return false end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then

		if ( CLIENT ) then

			self:ClearObjects()
			return true

		end

		-- Get client's CVars
		local forcelimit = clamp( self:GetClientNumber( "forcelimit" ), 0, 1000 )
		local addlength = clamp( self:GetClientNumber( "addlength" ), -500, 500 )
		local material = self:GetClientInfo( "material" )
		local width = clamp( self:GetClientNumber( "width" ), 0, 10 )
		local fo = clamp( self:GetClientNumber( "firstoffset" ), -500, 500 )
		local so = clamp( self:GetClientNumber( "secondoffset" ), -500, 500 )
		local vo = clamp( self:GetClientNumber( "verticaloffset" ), -500, 500 )
		local rigid = self:GetClientNumber( "rigid" ) == 1

		-- Get info
		local Ent1, Ent2 = self:GetEnt( 1 ), self:GetEnt( 2 )
		local Bone1, Bone2 = self:GetBone( 1 ), self:GetBone( 2 )
		local Phys1, Phys2 = self:GetPhys( 1 ), self:GetPhys( 2 )
		local Mc1 = Phys1:GetMassCenter()
		local Mc2 = Phys2:GetMassCenter()
		local WPos1, WPos2 = Phys1:LocalToWorld( Mc1 ), Phys2:LocalToWorld( Mc2 )
		local length = ( WPos1 - WPos2 ):Length()
		local atoba = Phys1:WorldToLocal( WPos2 ):Angle()
		local btoaa = Phys2:WorldToLocal( WPos1 ):Angle()
		if ( not ( fo == 0 ) ) or ( not ( so == 0 ) ) then
		
			if fo + so > length then
				
				net.Start( "tylarstools_ropemasscenter_tooshort" )
				net.Send( self:GetOwner() )
				fo = 0
				so = 0
			
			end
			
		end
		
		length = length - so - fo
		local absvec = Vector( 0, 0, vo )
		
		-- create the rope
		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, Mc1 + ( atoba:Forward() * fo ) + absvec, Mc2 + ( btoaa:Forward() * so ) + absvec, length, addlength, forcelimit, width, material, rigid )

		-- Clear the objects and set the last object as object 1
		self:ClearObjects()

		iNum = self:NumObjects()
		self:SetObject( iNum + 1, Ent2, trace.HitPos, Phys, Bone2, trace.HitNormal )
		self:SetStage( iNum + 1 )

		-- Add The constraint to the players undo table
		undo.Create( "Rope Mass Center (" .. string.StripExtension( string.GetFileFromFilename( Ent1:GetModel() ) ) .. " " .. Ent1:EntIndex() .. " - " .. string.StripExtension( string.GetFileFromFilename( Ent2:GetModel() ) ) .. " " .. Ent2:EntIndex() .. ")" )
			undo.AddEntity( constraint )
			if iv( rope ) then
				undo.AddEntity( rope )
			end
			undo.SetPlayer( self:GetOwner() )
			undo.SetCustomUndoText( "Undone Rope Mass Center (Chain)" )
		undo.Finish()

		self:GetOwner():AddCleanup( "ropeconstraints", constraint )
		self:GetOwner():AddCleanup( "ropeconstraints", rope )

	else

		self:SetStage( iNum + 1 )

	end

	return true

end

function TOOL:Reload( trace )

	if ( not ( iv( trace.Entity ) ) or trace.Entity:IsPlayer() ) then return false end
	if ( CLIENT ) then return true end
	
	if SERVER and ( not tylarstools.cantarget( self:GetOwner(), trace.Entity ) ) then return false end
	
	return constraint.RemoveConstraints( trace.Entity, "Rope" )

end

function TOOL:Holster()

	self:ClearObjects()

end


-- build presets

-- default preset:
local ConVarsDefault = TOOL:BuildConVarList()

-- "perfect couple" preset:
local ConVarsCouple = table.Copy( ConVarsDefault )
ConVarsCouple["ropemasscenter_firstoffset"] = 80
ConVarsCouple["ropemasscenter_secondoffset"] = 80

-- "bmw" preset:
local ConVarsBMW = table.Copy( ConVarsDefault )
ConVarsBMW["ropemasscenter_firstoffset"] = 64
ConVarsBMW["ropemasscenter_secondoffset"] = 46


function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.ropemasscenter.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "ropemasscenter", Options = { [ "#preset.default" ] = ConVarsDefault, [ "#tool.ropemasscenter.preset_couple" ] = ConVarsCouple, [ "#tool.ropemasscenter.preset_bmw" ] = ConVarsBMW, }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.forcelimit", Command = "ropemasscenter_forcelimit", Type = "Float", Min = 0, Max = 1000, Help = true } )
	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.addlength", Command = "ropemasscenter_addlength", Type = "Float", Min = -500, Max = 500, Help = false } )

	CPanel:AddControl( "CheckBox", { Label = "#tool.rope.rigid", Command = "ropemasscenter_rigid", Help = false } )

	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.width", Command = "ropemasscenter_width", Type = "Float", Min = 0, Max = 10 } )
	CPanel:AddControl( "RopeMaterial", { Label = "#tool.rope.material", ConVar = "ropemasscenter_material" } )
	
	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.offseta", Command = "ropemasscenter_firstoffset", Type = "Float", Min = -500, Max = 500, Help = true } )
	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.offsetb", Command = "ropemasscenter_secondoffset", Type = "Float", Min = -500, Max = 500, Help = true } )
	CPanel:AddControl( "Slider", { Label = "#tool.ropemasscenter.offsetc", Command = "ropemasscenter_verticaloffset", Type = "Float", Min = -500, Max = 500, Help = true } )


end