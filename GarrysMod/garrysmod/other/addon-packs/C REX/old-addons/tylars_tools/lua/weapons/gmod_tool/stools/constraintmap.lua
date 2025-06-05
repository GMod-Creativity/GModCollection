local iv = IsValid
local color_chat = Color( 214, 185, 111, 255 )
local color_bg = Color( 0, 0, 0, 155 )
local abs = math.abs
local tool_timer = {}
local can_clear_hud = true

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

if SERVER then

	util.AddNetworkString( "SyncConMapData" )

end

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Constraints"
TOOL.Name = "Constraint Map"
TOOL.Command = nil
TOOL.ConfigName = nil

if CLIENT then

	language.Add( "tool.constraintmap.name", "Constraint Map" )
	language.Add( "tool.constraintmap.desc", "Visualizes an entity's constraints." )
	language.Add( "tool.constraintmap.help", "Allows you to view all the constraints on an entity in 3D. Checking \"Recursive\" will display every constraint in the tree, including constraints between entities that are constrainted to the main entity and entities that are not." )
	language.Add( "tool.constraintmap.left", "View an entity's constraints" )
	language.Add( "tool.constraintmap.right", "Clear constraint data from the HUD" )
	language.Add( "tool.constraintmap.background", "Dim the background" )
	language.Add( "tool.constraintmap.background.help", "Draw a black background behind the HUD visualization to aid visibility" )
	language.Add( "tool.constraintmap.recursive", "Check recursively" )
	language.Add( "tool.constraintmap.recursive.help", "Will check recursively for constraints (throughout the entire contraption, not just on the selected entity)." )
	
end

TOOL.ClientConVar[ "recursive" ] = "0"
TOOL.ClientConVar[ "background" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
}

local resolve_cons -- scoping

resolve_cons = function( ent, recursive, tbl_of_ents, tbl_of_cons, visited_ents, visited_cons )

	local tbl = constraint.GetTable( ent )
	
	for k,v in next, tbl, nil do
		
		local other_ent = v.Ent1 == ent and v.Ent2 or v.Ent1
		local con_id = v.Identity
		
		
		if not v.Identity then con_id = "nc" .. v.Ent1:EntIndex() .. v.Ent2:EntIndex() end
		
		if not visited_cons[con_id] then

			visited_cons[con_id] = true

			-- now evaluate the filter lists
			table.insert( tbl_of_ents, other_ent )
			table.insert( tbl_of_cons, { Ent1 = v.Ent1, Ent2 = v.Ent2, Identity = con_id, Type = v.Type } )
			-- recurse
			if recursive then

				resolve_cons( other_ent, recursive, tbl_of_ents, tbl_of_cons, visited_ents, visited_cons )

			end

		end
	
	end

end

local find_constraints = function( ent, recursive )

	local tbl_of_ents = {}
	local tbl_of_cons = {}
	
	resolve_cons( ent, recursive, tbl_of_ents, tbl_of_cons, { [ent] = true, }, {} )
	
	return table.Copy( tbl_of_cons ), #( tbl_of_cons )

end

function TOOL:LeftClick( trace ) -- modify
	
	if SERVER then
	
		local ent = trace.Entity
		local own = self:GetOwner()
		
		if iv( ent ) and iv( own ) then
			
			tool_timer[own] = tool_timer[own] or 0
			
			if tool_timer[own] + 2 <= CurTime() then
				
				tool_timer[own] = CurTime()
				
				local connum = 0
				local conmap_cons = {}
				local recursive = self:GetClientNumber( "recursive" ) == 1
				print( recursive and "it is recursive." or "it is not recursive." )

				conmap_cons, connum = find_constraints( ent, recursive )
				
				net.Start( "SyncConMapData" )
					net.WriteEntity( ent )
					net.WriteBool( recursive )
					net.WriteTable( conmap_cons )
				net.Send( own )
				
				return true
			
			end
		
		end
		
		return false
	
	end
	
	return true

end

if CLIENT then

	net.Receive( "SyncConMapData", function( len )
		
		local ent = net.ReadEntity()
		local recursive = net.ReadBool()
		local contab = net.ReadTable()
		LocalPlayer().conmap_cons = table.Copy( contab )
		
		local connum = #( contab )
		
		chat.AddText( color_chat, "[Constraint Map] ", color_white, "Entity " .. ent:EntIndex() .. " (" .. ent:GetModel() .. ") has " .. connum .. ( recursive and " recursive" or "" ) .. " constraints." )
	
	end )

end

function TOOL:RightClick( trace )
	
	if CLIENT then
		
		if can_clear_hud then
		
			LocalPlayer().conmap_cons = {}
			chat.AddText( color_chat, "[Constraint Map] ", color_white, "Cleared the HUD." )

			can_clear_hud = false

			timer.Simple( 0.05, function()

				can_clear_hud = true

			end )
		
		end
		
		return true
	
	end
	
	return false

end

-- reload and holster should stay empty

function TOOL:Reload( trace )

end

function TOOL:Holster()

end


local drawing_red = Color( 255, 0, 0, 255 )

local concolors = {
	["Rope"] = Color( 255, 155, 0, 255 ),
	["Weld"] = Color( 255, 0, 0, 255 ),
	["Axis"] = Color( 0, 155, 255, 255 ),
	["Ballsocket"] = Color( 0, 0, 255, 255 ),
	["AdvBallsocket"] = Color( 0, 0, 255, 255 ),
	["NoCollide"] = Color( 255, 255, 0, 255 ),
	["Winch"] = color_white,
	["Slider"] = color_white,
	["Muscle"] = Color( 255, 255, 255, 255 ),
	["Motor"] = Color( 0, 255, 0, 255 ),
	["Hydraulic"] = Color( 155, 155, 255, 255 ),
	["Elastic"] = Color( 255, 155, 255, 255 ),
}

local outlinecolors = {
	["Ballsocket"] = color_white,
	["AdvBallsocket"] = color_white,
	["Winch"] = Color( 255, 0, 100, 255 ),
	["Slider"] = Color( 200, 0, 255, 255 ),
}

if CLIENT then

	function TOOL:DrawHUD()
		
		local own = self:GetOwner()
		local et = own:GetEyeTrace()

		if iv( et.Entity ) then
			
			draw.SimpleTextOutlined( et.Entity:EntIndex() .. " | " .. et.Entity:GetModel(), "DermaDefault", ScrW() / 2, ScrH() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black )

		end
		
		own.conmap_cons = own.conmap_cons or {}
		local ccount = #( own.conmap_cons )
		
		if ccount > 0 then
		
			local bg = GetConVarNumber( "constraintmap_background" ) == 1
			
			if bg then
			
				surface.SetDrawColor( color_bg )
				surface.DrawRect( 0, 0, ScrW(), ScrH() )
			
			end
		
			for i = 1, ccount do
			
				local con = own.conmap_cons[i]
				
				if iv( con.Ent1 ) and iv( con.Ent2 ) then
					
					local col = concolors[con.Type] or drawing_red
					surface.SetDrawColor( col )
					
					local p1 = con.Ent1:GetPos():ToScreen()
					local p2 = con.Ent2:GetPos():ToScreen()
					local textpos = ( ( con.Ent1:GetPos() + con.Ent2:GetPos() ) / 2 ):ToScreen()
					local e1id = con.Ent1:EntIndex()
					local e2id = con.Ent2:EntIndex()
					
					if e1id > e2id then
					
						local tmp = e1id
						e1id = e2id
						e2id = tmp
					
					end
					
					surface.DrawLine( p1.x, p1.y, p2.x, p2.y )
					
					draw.SimpleTextOutlined( e1id .. " | " .. con.Type .. " | " .. e2id, "DermaDefault", textpos.x, textpos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outlinecolors[con.Type] or color_black ) 

				end
				
			end
		
		end
		
		surface.SetDrawColor( color_white )
	
	end

end

-- right side panel list

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.constraintmap.help" } )
	CPanel:AddControl( "Checkbox", { Label = "#tool.constraintmap.background", Command = "constraintmap_background", Help = true } )
	CPanel:AddControl( "Checkbox", { Label = "#tool.constraintmap.recursive", Command = "constraintmap_recursive", Help = true } )


	
end