local ivpo = util.IsValidPhysicsObject
local iv = IsValid
local ti = table.insert
local tc = table.Count
local tcn = table.concat
local rnd = math.Round
local clamp = math.Clamp
local utl = util.TraceLine
local ugpt = util.GetPlayerTrace
local filename = string.GetFileFromFilename
local fmt = string.format
local trim = string.TrimRight
local ts = tostring

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

ICE_PTH_CHILD = 0
ICE_PTH_PARENT = 1

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Construction"
TOOL.Name = "Prop to Holo"
TOOL.Command = nil
TOOL.ConfigName = nil

if CLIENT then

	language.Add( "tool.prop_to_holo.name", "Prop to Holo" )
	language.Add( "tool.prop_to_holo.desc", "Convert props into E2 holos with positions relative to a parent E2 chip." )
	language.Add( "tool.prop_to_holo.help", "This tool allows for mass conversion of physics props into Expression2 holos. Select an entity to serve as the parent (the chip that will create the holos) by right-clicking it. Next, left-click on anything you want to be converted to a holo. Holding shift+left click allows you to area-select entities. To deselect, simply left-click on a selected entity, or right-click on the parent." )
	language.Add( "tool.prop_to_holo.left", "Select entities to be converted into E2 holos" )
	language.Add( "tool.prop_to_holo.right", "Select an entity to serve as the parent" )
	language.Add( "tool.prop_to_holo.reload", "Cancel/clear all selected entities" )
	language.Add( "tool.prop_to_holo.copysize", "Area select size: " )
	language.Add( "tool.prop_to_holo.copysize.help", "The size of the bounding box in which entities will be marked for holo conversion (in source units)" )
		--[[
		
		TOOL.ClientConVar[ "copysize" ] = "128"
		TOOL.ClientConVar[ "color" ] = "1"
		TOOL.ClientConVar[ "material" ] = "1"
		TOOL.ClientConVar[ "skin" ] = "1"
		TOOL.ClientConVar[ "bodygroup" ] = "1"
		TOOL.ClientConVar[ "renderfx" ] = "1"
		TOOL.ClientConVar[ "clipboard" ] = "1"
		
		]]
	language.Add( "tool.prop_to_holo.color", "Keep original colors" )
	language.Add( "tool.prop_to_holo.material", "Keep material override" )
	language.Add( "tool.prop_to_holo.skin", "Keep original skin" )
	language.Add( "tool.prop_to_holo.bodygroup", "Keep bodygroups" )
	language.Add( "tool.prop_to_holo.renderfx", "Keep original RenderFX" )
	language.Add( "tool.prop_to_holo.clipboard", "Output to clipboard instead of a popup window" )
	
end

TOOL.ClientConVar[ "copysize" ] = "512"
TOOL.ClientConVar[ "color" ] = "1"
TOOL.ClientConVar[ "material" ] = "0"
TOOL.ClientConVar[ "skin" ] = "1"
TOOL.ClientConVar[ "bodygroup" ] = "1"
TOOL.ClientConVar[ "renderfx" ] = "0"
TOOL.ClientConVar[ "clipboard" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" },
}

-- network strings & receivers

if SERVER then

	util.AddNetworkString( "tylarstools_prop_to_holo_capentity_left" )
	util.AddNetworkString( "tylarstools_prop_to_holo_confirm_left" )
	util.AddNetworkString( "tylarstools_prop_to_holo_capentity_right" )
	util.AddNetworkString( "tylarstools_prop_to_holo_confirm_right" )
	
	net.Receive( "tylarstools_prop_to_holo_capentity_left", function( len, ply )
	
		local ent = net.ReadEntity()
		
		if iv( ply ) and iv( ent ) then
			
			if not ent:IsPlayer() then
			
				if tylarstools.cantarget( ply, ent ) then
				
					net.Start( "tylarstools_prop_to_holo_confirm_left" )
						net.WriteEntity( ent )
					net.Send( ply )
				
				end
			
			end
		
		end
	
	end )
	
	net.Receive( "tylarstools_prop_to_holo_capentity_right", function( len, ply )
	
		local ent = net.ReadEntity()
		
		if iv( ply ) and iv( ent ) then
			
			if not ent:IsPlayer() then
			
				if tylarstools.cantarget( ply, ent ) then
				
					net.Start( "tylarstools_prop_to_holo_confirm_right" )
						net.WriteEntity( ent )
					net.Send( ply )
				
				end
			
			end
		
		end
	
	end )

end

if CLIENT then
	
	-- these have to be put up here because fuck scoping
	local can_select_l = true
	local can_select_r = true
	local can_select_reload = true
	local ents_selected = {}
	local entity_select
	local ent_parent
	
	entity_select = function( ent, status, role )
		
		if iv( ent ) then
			
			local eid = ent:EntIndex()
			
			if status then -- selected
				
				-- store old color
				ent.pth_oldmaterial = ent:GetMaterial()
				ent.pth_oldcolor = ent:GetColor()
				ent.pth_oldrenderfx = ent:GetRenderFX()
				ent.pth_oldrendermode = ent:GetRenderMode()
				ent.pth_oldskin = ent:GetSkin()
				ent.pth_oldbodygroups = ent:GetBodyGroups()
				
				-- set new color
				ent:SetMaterial( "tools/toolswhite", true )
				ent:SetColor( role == ICE_PTH_PARENT and ent_color_parent or ent_color_child )
				ent:SetRenderMode( RENDERMODE_TRANSALPHA )
				
				-- stash entity away
				if role == ICE_PTH_CHILD then
				
					ents_selected[eid] = true
				
				elseif role == ICE_PTH_PARENT then
					
					if ent_parent then
					
						entity_select( Entity( ent_parent ), false )
					
					end
					
					ent_parent = eid
				
				end
				
				ent.pth_selected = true
				
				return true
			
			else -- deselected
				
				-- reset to old material
				if ent.pth_oldmaterial then

					ent:SetMaterial( ent.pth_oldmaterial )

				end
				
				-- reset to old color
				if ent.pth_oldcolor then

					ent:SetColor( ent.pth_oldcolor )
				
				end
				
				-- reset to old rendermode
				if ent.pth_oldrendermode then
					
					ent:SetRenderMode( ent.pth_oldrendermode )
				
				end
				
				-- clear out
				if ents_selected[eid] then
				
					ents_selected[eid] = nil
				
				elseif eid == ent_parent then
				
					ent_parent = nil
				
				end
				
				ent.pth_selected = false
			
			end
		
		end
	
	end
	
	-- the thing that actually compiles the code
	local compile_holo_text = function( start_offset )
		
		local holo_id = 1 + start_offset
		local line_end = "\n    "
		local hst = {
			"# Generated holo code from Prop to Holo tool.\n",
			"if( first() | dupefinished() ){\n\n",
			"    HPE = entity()\n\n",
			"    HoloID = ",
			holo_id,
			"\n\n",
		}
		
		if ent_parent then
			
			local parent_ent = Entity( ent_parent )
			
			if iv( parent_ent ) then
				
				local parent_pos = parent_ent:GetPos()
				local parent_ang = parent_ent:GetAngles()
				
				
				for k,v in next, ents_selected, nil do
				
					if k and v then
					
						local toholo = Entity( k )
						
						if iv( toholo ) then
						
							local convars = {
								["copysize"] = GetConVar( "prop_to_holo_copysize" ),
								["color"] = GetConVar( "prop_to_holo_color" ),
								["material"] = GetConVar( "prop_to_holo_material" ),
								["skin"] = GetConVar( "prop_to_holo_skin" ),
								["bodygroup"] = GetConVar( "prop_to_holo_bodygroup" ),
								["renderfx"] = GetConVar( "prop_to_holo_renderfx" ),
								["clipboard"] = GetConVar( "prop_to_holo_clipboard" ),
							}
							
							local use_bodygroups = convars["bodygroup"]:GetInt() == 1
							local use_color = convars["color"]:GetInt() == 1
							local use_skin = convars["skin"]:GetInt() == 1
							local use_material = convars["material"]:GetInt() == 1
							local use_renderfx = convars["renderfx"]:GetInt() == 1
							local use_clipboard = convars["clipboard"]:GetInt() == 1
							
							local h_model = toholo:GetModel()
							local h_scale = toholo:GetModelScale()
							local h_pos = parent_ent:WorldToLocal( toholo:GetPos() )
							local h_ang = parent_ent:WorldToLocalAngles( toholo:GetAngles() )
							
							local h_color = use_color and toholo.pth_oldcolor or Color( 255, 255, 255, 255 )
							local h_skin = toholo.pth_oldskin
							local h_material = toholo.pth_oldmaterial
							local h_renderfx = toholo.pth_oldrenderfx
							
							local h_bodygroups = {}
							local bgnames = {}
							local bgs = toholo.pth_oldbodygroups
							
							if use_bodygroups and not ( ( #( bgs ) == 1 ) and ( bgs[1]["num"] == 1 ) ) then
							
								for _, bgtbl in next, bgs, nil do
								
									h_bodygroups[bgtbl.id] = toholo:GetBodygroup( bgtbl.id )
									bgnames[bgtbl.id] = bgtbl["name"]
								
								end
							
							end
							
							-- comment - lua entindex
							ti( hst, "    # Lua EntIndex: " )
							ti( hst, toholo:EntIndex() )
							ti( hst, line_end )
							
							
							-- holoCreate
							ti( hst, "holoCreate( HoloID, HPE:toWorld( vec( " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_pos.x ) ), "0" ), "." ) )
							ti( hst, ", " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_pos.y ) ), "0" ), "." ) )
							ti( hst, ", " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_pos.z ) ), "0" ), "." ) )
							-- scale
							ti( hst, " ) ), vec( " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_scale or 1 ) ), "0" ), "." ) )
							-- angle
							ti( hst, " ), HPE:toWorld( ang( " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_ang.p ) ), "0" ), "." ) )
							ti( hst, ", " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_ang.y ) ), "0" ), "." ) )
							ti( hst, ", " )
							ti( hst, trim( trim( fmt( "%.12f", ts( h_ang.r ) ), "0" ), "." ) )
							ti( hst, " ) ), vec( " )
							-- color
							ti( hst, h_color.r )
							ti( hst, ", " )
							ti( hst, h_color.g )
							ti( hst, ", " )
							ti( hst, h_color.b )
							-- model
							ti( hst, " ), \"" )
							ti( hst, h_model )
							ti( hst, "\" )" )
							ti( hst, line_end )
							
							
							-- holoAlpha
							ti( hst, "holoAlpha( HoloID, " )
							ti( hst, h_color.a )
							ti( hst, " )" )
							ti( hst, line_end )
							
							if use_bodygroups then
							
								-- holoBodygroup
								for id, choice in next, h_bodygroups, nil do
								
									ti( hst, "holoBodygroup( HoloID, " )
									ti( hst, id )
									ti( hst, ", " )
									ti( hst, choice )
									ti( hst, " ) # Bodygroup name: " )
									ti( hst, bgnames[id] )
									ti( hst, line_end )
								
								end
							
							end
							
							
							if use_skin then
							
								-- holoSkin
								ti( hst, "holoSkin( HoloID, " )
								ti( hst, h_skin )
								ti( hst, " )" )
								ti( hst, line_end )
							
							end
							
							
							if use_material and not ( h_material == "" ) then
							
								-- holoMaterial
								ti( hst, "holoMaterial( HoloID, \"" )
								ti( hst, h_material )
								ti( hst, "\" )" )
								ti( hst, line_end )
							
							end
							
							if use_renderfx then
							
								-- holoMaterial
								ti( hst, "holoRenderFX( HoloID, " )
								ti( hst, h_renderfx )
								ti( hst, " )" )
								ti( hst, line_end )
							
							end
							
							
							-- holoParent
							ti( hst, "holoParent( HoloID, HPE )" )
							ti( hst, line_end )
							ti( hst, line_end )
							
							-- increment HoloID
							ti( hst, "HoloID = HoloID + 1" )
							ti( hst, line_end )
							ti( hst, "\n" )
						
						end
					
					end
				
				end
			
			end
		
		end
		
		convars = nil
		ti( hst, "} \n " )
		return table.Copy( hst )
		
	end
	
	-- create hook to deselect entities if they are removed at any point in time.
	hook.Add( "EntityRemoved", "tylarstools_prop_to_holo_EntityRemoved", function( ent )
		
		local eid = ent:EntIndex()
		
		if ent_parent == eid then
		
			entity_select( ent, false )
			chat.AddText( ent_color_parent, "[PtoH] De-parented " .. eid .. "[" .. ent:GetClass() .. "](" .. filename( ent:GetModel() ) .. ")" )
			can_select_r = true
		
		elseif ents_selected[ent:EntIndex()] then
		
			entity_select( ent, false )
			chat.AddText( ent_color_child, "[PtoH] De-selected " .. eid .. "[" .. ent:GetClass() .. "](" .. filename( ent:GetModel() ) .. ")" )
			can_select_l = true
		
		end
	
	end )

	net.Receive( "tylarstools_prop_to_holo_confirm_left", function( len )
	
		local ent = net.ReadEntity()
		
		if iv( ent ) then
			
			entity_select( ent, true, ICE_PTH_CHILD )
			chat.AddText( ent_color_child, "[PtoH] Selected " .. ent:EntIndex() .. "[" .. ent:GetClass() .. "](" .. filename( ent:GetModel() ) .. ")" )
			timer.Remove( "override_lc_pth" )
			
		end
		
		timer.Simple( 0.2, function() can_select_l = true end )
	
	end )
	
	net.Receive( "tylarstools_prop_to_holo_confirm_right", function( len )
	
		local ent = net.ReadEntity()
		
		if iv( ent ) then
		
			entity_select( ent, true, ICE_PTH_PARENT )
			chat.AddText( ent_color_parent, "[PtoH] Set parent " .. ent:EntIndex() .. "[" .. ent:GetClass() .. "](" .. filename( ent:GetModel() ) .. ")" )
			timer.Remove( "override_lc_pth" )
		
		end
		
		timer.Simple( 0.2, function() can_select_r = true end )
	
	end )

	-- left and right click

	function TOOL:LeftClick( trace ) -- send client trace entity to server for verification
		
		self.reloadtimer = 0
		
		if can_select_l then
			
			can_select_l = false
			
			local trace_override = LocalPlayer():GetEyeTrace()
			
			if iv( trace_override.Entity ) then
				
				local eid = trace_override.Entity:EntIndex()
				
				if ents_selected[eid] then
				
					entity_select( trace_override.Entity, false )
					chat.AddText( ent_color_child, "[PtoH] De-selected " .. eid .. "[" .. trace_override.Entity:GetClass() .. "](" .. filename( trace_override.Entity:GetModel() ) .. ")" )
					timer.Simple( 0.2, function() can_select_l = true end )
					return true
				
				elseif ent_parent == eid then
				
					chat.AddText( ent_color_confirm, "[PtoH] Error - can't select the parent entity." )
					timer.Simple( 0.2, function() can_select_l = true end )
					return true
				
				else
				
					net.Start( "tylarstools_prop_to_holo_capentity_left" )
						net.WriteEntity( trace_override.Entity )
					net.SendToServer()
					timer.Simple( 0.2, function() can_select_l = true end )
					
					return true
				
				end
				
			end
			
		end
		
		timer.Simple( 0.2, function() can_select_l = true end )
		return false

	end

	function TOOL:RightClick( trace ) -- send client trace entity to server for verification
		
		self.reloadtimer = 0
		
		if can_select_r then
		
			can_select_r = false
			
			local trace_override = utl( ugpt( LocalPlayer() ) )
			
			if iv( trace_override.Entity ) then
				
				if ents_selected[trace_override.Entity:EntIndex()] then
				
					chat.AddText( ent_color_confirm, "[PtoH] Error - can't parent a selected entity." )
					timer.Simple( 0.2, function() can_select_r = true end )
					return true
				
				elseif ent_parent == trace_override.Entity:EntIndex() then
					
					entity_select( trace_override.Entity, false )
					chat.AddText( ent_color_parent, "[PtoH] De-parented " .. trace_override.Entity:EntIndex() .. "[" .. trace_override.Entity:GetClass() .. "](" .. filename( trace_override.Entity:GetModel() ) .. ")" )
					timer.Simple( 0.2, function() can_select_r = true end )
					return true
				
				else
				
					net.Start( "tylarstools_prop_to_holo_capentity_right" )
						net.WriteEntity( trace_override.Entity )
					net.SendToServer()
					timer.Simple( 0.2, function() can_select_r = true end )
					
					return true
				
				end
				
			end
		
		end
		
		timer.Simple( 0.2, function() can_select_r = true end )
		return false

	end
	
	function TOOL:Reload( trace )
		
		if can_select_reload then
			
			can_select_reload = false
			self.reloadtimer = self.reloadtimer or 0
			
			if CurTime() > self.reloadtimer then
				
				chat.AddText( chat_color_confirm, "[PtoH] Are you sure you want to clear all selected entities?" )
				chat.AddText( chat_color_confirm, "[PtoH] Hit Reload again in the next 5 seconds to confirm." )
				self.reloadtimer = CurTime() + 5
				timer.Simple( 0.2, function() can_select_reload = true end )
				return true
			
			else
				
				self.reloadtimer = 0
				
				-- deselect all children
				for k,v in next, ents_selected, nil do
				
					entity_select( Entity( k ), false )
				
				end
				
				-- deselect parent
				if ent_parent and iv( Entity( ent_parent ) ) then
				
					entity_select( Entity( ent_parent ), false )
				
				end
				
				chat.AddText( chat_color_confirm, "[PtoH] Cleared all selected entities and holo parent." )
				timer.Simple( 0.2, function() can_select_reload = true end )
				return true
			
			end
			
			can_select_reload = true
		
		end
		
		timer.Simple( 1, function() can_select_reload = true end )
		return false
		
	end
	
	function TOOL:Holster()
		
		can_select_l = true
		can_select_r = true
		can_select_reload = true
		self.reloadtimer = 0
		
	end
	
	local color_trans_black = Color( 0, 0, 0, 230 )
	
	function TOOL:DrawHUD()
		
		local wo = ( ScrW() / 2 )
		local ho = 5 * ( ScrH() / 6 )
		
		-- draw selected entity count
		surface.SetDrawColor( color_trans_black )
		surface.DrawRect( wo - 100, ho, 200, 32 )
		draw.SimpleText( "Selected count: " .. tc( ents_selected ), "HudHintTextLarge", wo, ho + 16, ent_color_child, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		-- draw selected parent if there is one
		
		if ent_parent then
	
			surface.DrawRect( wo - 100, ho + 44, 200, 32 )
			draw.SimpleText( "Parent EntIndex: " .. ent_parent, "HudHintTextLarge", wo, ho + 60, ent_color_parent, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		
		
	
	end
	
	-- right side panel list
	local ConVarsDefault = TOOL:BuildConVarList()

	function TOOL.BuildCPanel( CPanel )

		CPanel:AddControl( "Header", { Description = "#tool.prop_to_holo.help" } )
		CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "prop_to_holo", Options = { [ "#preset.default" ] = ConVarsDefault, }, CVars = table.GetKeys( ConVarsDefault ) } )
		CPanel:AddControl( "Slider", { Label = "#tool.prop_to_holo.copysize", Command = "prop_to_holo_copysize", Type = "Float", Min = 0, Max = 1024, Help = true } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.color", Command = "prop_to_holo_color", Help = false } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.material", Command = "prop_to_holo_material", Help = false } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.skin", Command = "prop_to_holo_skin", Help = false } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.bodygroup", Command = "prop_to_holo_bodygroup", Help = false } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.renderfx", Command = "prop_to_holo_renderfx", Help = false } )
		CPanel:AddControl( "CheckBox", { Label = "#tool.prop_to_holo.clipboard", Command = "prop_to_holo_clipboard", Help = false } )
		
		local btn = CPanel:Button( "", "", "" )
		
		if btn then
			
			btn:SetText( "" )
			btn:SetHeight( 24 )
			btn.facetext = "Get holo code"
			btn.icon = tylarstools.characters.forward
			
			-- paint it
			function btn:DoClick()
				
				local res = compile_holo_text( 0 )
				
				local cbconvar = GetConVar( "prop_to_holo_clipboard" )
				
				if cbconvar:GetInt() == 1 then
				
					SetClipboardText( tcn( res, "" ) )
					surface.PlaySound( "ui/buttonclick.wav" )
					self.facetext = "Copied to Clipboard"
					self.icon = tylarstools.characters.check
					timer.Simple( 2, function()
					
						if iv( self ) then
						
							self.facetext = "Get holo code"
							self.icon = tylarstools.characters.forward
						
						end
					
					end )
				
				else
				
					local res_window = vgui.Create( "DFrame" )
					res_window:SetSize( 800, 600 )
					res_window:Center()
					res_window:SetTitle( "Prop to Holo Result" )
					res_window:SetDraggable( true )
					res_window:SetDeleteOnClose( true )
					res_window:MakePopup()
					
					res_window.code = vgui.Create( "RichText", res_window )
					res_window.code:Dock( FILL )
					
					for k,v in next, res, nil do
					
						res_window.code:AppendText( v )
						
					end
					
					function res_window.code:PerformLayout()
					
						res_window.code.m_FontName = "BudgetLabel"
						res_window.code:SetFontInternal( "BudgetLabel" )
						res_window.code:SetBGColor( Color( 44, 44, 44, 255 ) )
						res_window.code:SetFGColor( 255, 255, 255, 255 )
					
					end
				
				end
				
				cbconvar = nil
				
				surface.PlaySound( "ui/buttonclick.wav" )
			
			end
			
			function btn:Paint( w, h )
				
				local ih = self:IsHovered()
				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_green_color, false, true, false, true )
				draw.SimpleText( self.icon, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )
				
				draw.SimpleText( self.facetext, "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				
			end
		
		end


	end

end

if SERVER then

	function TOOL:LeftClick( trace )
	
		return false
	
	end
	
	function TOOL:RightClick( trace )
	
		return false
	
	end
	
	function TOOL:Reload()
	
		return false
	
	end
	
	function TOOL:Holster()
	
	end

end