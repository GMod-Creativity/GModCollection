local ivpo = util.IsValidPhysicsObject
local iv = IsValid
local ti = table.insert
local rnd = math.Round
local clamp = math.Clamp

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Construction"
TOOL.Name = "Buoyancy Ratio"
TOOL.Command = nil
TOOL.ConfigName = nil

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

if CLIENT then

	language.Add( "tool.buoyancyratio.name", "Set Buoyancy Ratio" )
	language.Add( "tool.buoyancyratio.desc", "Set an entity's buoyancy ratio." )
	language.Add( "tool.buoyancyratio.help", "An entity's buoyancy ratio determines how well it will float in water. A ratio of 0 would make an entity sink like a rock, while a ratio of 1 would make an entity extremely buoyant." )
	language.Add( "tool.buoyancyratio.left", "Set an entity's buoyancy ratio" )
	language.Add( "tool.buoyancyratio.right", "Copy an entity's buoyancy ratio" )
	language.Add( "tool.buoyancyratio.ratio", "Ratio (0 - 1): " )
	language.Add( "tool.buoyancyratio.ratio.help", "This should be a float (decimal) value between 0 and 1. 0 is least buoyant, and 1 is most buoyant. This cannot be reset." )
	
end

TOOL.ClientConVar[ "ratio" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
}

-- function for setting the buoyancy

local tylarstools_buoyancy_set = function( ply, ent, dat )

	local bfloat = clamp( dat[1], 0, 1 )
	
	local pcount = ent:GetPhysicsObjectCount()
	
	local physics_capable = false
	
	if pcount == 1 then
	
		local phys = ent:GetPhysicsObject()
		
		if iv( phys ) then
		
			phys:SetBuoyancyRatio( bfloat )
			phys:Wake()
			physics_capable = true
		
		end
	
	elseif pcount > 0 then
		
		local poi
		
		for i = 0, pcount - 1 do
			
			if ivpo( ent, i ) then
				
				poi = ent:GetPhysicsObjectNum( i )
				poi:SetBuoyancyRatio( bfloat )
				poi:Wake()
				physics_capable = true
			
			else
			
				physics_capable = false
				break
			
			end
		
		end
		
	end
	
	if physics_capable then
		
		ent.buoyancyratio = rnd( bfloat, 2 )
		ent:SetNWFloat( "buoyancy_ratio", ent.buoyancyratio )
		duplicator.StoreEntityModifier( ent, "buoyancy_ratio", dat )
		return true
		
	end
	
	return false

end

-- left and right click

function TOOL:LeftClick( trace ) -- modify
	
	if SERVER then
	
		local ent = trace.Entity
		local res = false
		local own = self:GetOwner()
		local bfloat
		
		if iv( ent ) and iv( own ) then
			
			if tylarstools.cantarget( own, ent ) then
			
				bfloat = self:GetClientNumber( "ratio" )
				res = tylarstools_buoyancy_set( own, ent, { bfloat, } )
			
			end
		
		end
		
		return res
	
	end
	
	return true

end

function TOOL:RightClick( trace ) -- copy
	
	if CLIENT then
	
		local ent = trace.Entity
		
		if iv( ent ) then
			
			local nwf = ent:GetNWFloat( "buoyancy_ratio", false )	
			
			if nwf then
			
				self:GetOwner():ConCommand( "buoyancyratio_ratio " .. rnd( nwf, 2 ) )
				return true
				
			end
		
		end
		
		return false
	
	end
	
	return true

end

-- reload and holster should stay empty

function TOOL:Reload( trace )

end

function TOOL:Holster()

end

if CLIENT then
	
	-- world tip
	function TOOL:Think()
	
		local et = self:GetOwner():GetEyeTrace()
		
		if iv( et.Entity ) then
			
			if ( et.StartPos - et.HitPos ):Length() < 512 then
			
				if not et.Entity:IsPlayer() then
				
					local nwf = et.Entity:GetNWFloat( "buoyancy_ratio", false )
					
					if nwf then
					
						AddWorldTip( nil, "Buoyancy ratio - " .. rnd( nwf, 2 ) .. " : 1", nil, et.Entity:GetPos(), nil )
					
					else
					
						AddWorldTip( nil, "Buoyancy ratio - (not set)", nil, et.Entity:GetPos(), nil )
					
					end
				
				end
			
			end
		
		end
	
	end

end

-- fix physgun & gravgun screwing it all up

if SERVER then
	
	local tylarstools_buoyancy_repair = function( ply, ent )
	
		if iv( ent ) then
		
			if ent.buoyancyratio then
				
				timer.Simple( 0.05, function()
				
					tylarstools_buoyancy_set( ply, ent, { ent.buoyancyratio, } )
				
				end )
			
			end
		
		end
	
	end
	
	hook.Add( "PhysgunDrop", "Tylarstools_Buoyancyratio_FixPhysgun", tylarstools_buoyancy_repair )
	hook.Add( "GravGunOnDropped", "Tylarstools_Buoyancyratio_FixPhysgun", tylarstools_buoyancy_repair )

end

-- duplicator shit

duplicator.RegisterEntityModifier( "buoyancy_ratio", tylarstools_buoyancy_set )

-- right side panel list

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.buoyancyratio.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "buoyancyratio", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Slider", { Label = "#tool.buoyancyratio.ratio", Command = "buoyancyratio_ratio", Type = "Float", Min = 0, Max = 1, Help = true } )

	

end