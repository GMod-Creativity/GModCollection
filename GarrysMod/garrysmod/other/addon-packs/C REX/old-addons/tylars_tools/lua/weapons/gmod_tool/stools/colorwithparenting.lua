local iv = IsValid
local Color = Color
local clamp = math.Clamp
local utl = util.TraceLine
local ugpt = util.GetPlayerTrace

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Render"
TOOL.Name = "Color Parented"
TOOL.Command = nil
TOOL.ConfigName = nil

TOOL.ClientConVar[ "r" ] = 255
TOOL.ClientConVar[ "g" ] = 255
TOOL.ClientConVar[ "b" ] = 255
TOOL.ClientConVar[ "a" ] = 255
TOOL.ClientConVar[ "mode" ] = "0"
TOOL.ClientConVar[ "fx" ] = "0"
TOOL.ClientConVar[ "ccrf" ] = "0"

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

	language.Add( "tool.colorwithparenting.name", "Color Parented Props" )
	language.Add( "tool.colorwithparenting.desc", "Set an entity's color regardless of parent/child status." )
	language.Add( "tool.colorwithparenting.help", "This is a rewritten color tool that allows you to color any entity, regardless of its parent/child status, meaning parented props can be colored without accidentally changing the color of the parent prop. Everything interfaces seamlessly with the normal color tool." )
	language.Add( "tool.colorwithparenting.left", "Set an entity's color" )
	language.Add( "tool.colorwithparenting.right", "Copy an entity's color" )
	language.Add( "tool.colorwithparenting.reload", "Reset an entity's color to pure white" )
	language.Add( "tool.colorwithparenting.color", "Color" )
	
end

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" },
}

if SERVER then

	util.AddNetworkString( "icetools_colorwithparenting_docapture" )
	util.AddNetworkString( "icetools_colorwithparenting_capentity_left" )

end

-- duplicator.RegisterEntityModifier is handled within the normal color tool to ensure cross-compatibility. the "colour" key is used, and spelled the British way intentionally, for this reason.

local tylarstools_colorwithparenting_setcolor = function( ply, ent, data )
	
	-- fix transparency fuckup - see colour tool for info
	if data.Color and ( data.Color.a < 255 ) and ( data.RenderMode == 0 ) then
	
		data.RenderMode = 1
		
	end
	
	-- color?
	if data.Color then
	
		ent:SetColor( Color( data.Color.r, data.Color.g, data.Color.b, data.Color.a ) )
		
	end
	
	-- rendermode?
	if data.RenderMode then
	
		ent:SetRenderMode( data.RenderMode )
		
	end
	
	-- render FX?
	if data.RenderFX then
	
		ent:SetKeyValue( "renderfx", data.RenderFX )
		
	end
	
	-- store entity modifier for the duplicator under the normal color tool's modifier.
	if ( SERVER ) then
	
		duplicator.StoreEntityModifier( ent, "colour", data )
		
	end

end

-- left and right click

local pcs = {}
local expect = {}

if SERVER then

	net.Receive( "icetools_colorwithparenting_capentity_left", function( len, ply )
	
		local ent = net.ReadEntity()

		if iv( ply ) and iv( ent ) then
			
			local sid = ply:SteamID()
			
			if expect[sid] and pcs[sid] then
				
				expect[sid] = false
				
				if tylarstools.cantarget( ply, ent ) then
				
					tylarstools_colorwithparenting_setcolor( ply, ent, { Color = Color( pcs[sid]["r"], pcs[sid]["g"], pcs[sid]["b"], pcs[sid]["a"] ), RenderMode = pcs[sid]["mode"], RenderFX = pcs[sid]["fx"], } )
				
				end
			
			end
		
		end
	
	end )

end

if CLIENT then

	
	
	-- get the capture
	net.Receive( "icetools_colorwithparenting_docapture", function( len )

		local trace = utl( ugpt( LocalPlayer() ) )
		
		if iv( trace.Entity ) then
		
			net.Start( "icetools_colorwithparenting_capentity_left" )
				net.WriteEntity( trace.Entity )
			net.SendToServer()
		
		end
	
	end )

end

function TOOL:LeftClick( trace )
	
	if SERVER then
	
		local own = self:GetOwner()
		
		if iv( own ) then
		
			local sid = own:SteamID()
			
			pcs[sid] = {
			
				["r"] = clamp( self:GetClientNumber( "r", 0 ), 0, 255 ),
				["g"] = clamp( self:GetClientNumber( "g", 0 ), 0, 255 ),
				["b"] = clamp( self:GetClientNumber( "b", 0 ), 0, 255 ),
				["a"] = clamp( self:GetClientNumber( "a", 0 ), 0, 255 ),
				["fx"] = self:GetClientNumber( "fx", 0 ),
				["mode"] = self:GetClientNumber( "mode", 0 ),
				
			}
			
			expect[sid] = true
			net.Start( "icetools_colorwithparenting_docapture" )
			net.Send( own )
			
			return true
		
		end
	
	else
	
		return true
	
	end
	
	return false

end

function TOOL:RightClick( trace )
	
	if CLIENT then
		
		local own = self:GetOwner()
		
		local override_trace = utl( ugpt( own ) )
		
		local ent = override_trace.Entity
		
		if iv( ent ) then
		
			local clr = ent:GetColor()
			own:ConCommand( "colorwithparenting_r " .. clr.r )
			own:ConCommand( "colorwithparenting_g " .. clr.g )
			own:ConCommand( "colorwithparenting_b " .. clr.b )
			own:ConCommand( "colorwithparenting_a " .. clr.a )
			own:ConCommand( "colorwithparenting_fx " .. ent:GetRenderFX() )
			own:ConCommand( "colorwithparenting_mode " .. ent:GetRenderMode() )
		
		end
	
	end

	return true

end

function TOOL:Reload( trace ) -- hue
	
	if SERVER then
	
		local own = self:GetOwner()
		
		if iv( own ) then
		
			local sid = own:SteamID()
			
			pcs[sid] = {
			
				["r"] = 255,
				["g"] = 255,
				["b"] = 255,
				["a"] = 255,
				["fx"] = 0,
				["mode"] = 0,
				
			}
			
			expect[sid] = true
			net.Start( "icetools_colorwithparenting_docapture" )
			net.Send( own )
			
			return true
		
		end
	
	else
	
		return true
	
	end
	
	return false

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.colorwithparenting.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "colour", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Color", { Label = "#tool.colorwithparenting.color", Red = "colorwithparenting_r", Green = "colorwithparenting_g", Blue = "colorwithparenting_b", Alpha = "colorwithparenting_a" } )

	CPanel:AddControl( "ListBox", { Label = "#tool.colour.mode", Options = list.Get( "RenderModes" ) } )
	CPanel:AddControl( "ListBox", { Label = "#tool.colour.fx", Options = list.Get( "RenderFX" ) } )



end

