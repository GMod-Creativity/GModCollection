local ins = table.insert
local iv = IsValid

tylarstools = {
	characters = { -- for Marlett
		check = "a",
		cross = "r",
		forward = "4",
	}, 
	empty = {},
	hudcomponents = {
		["CHudAmmo"] = false,
		["CHudSecondaryAmmo"] = false,
		["CHudBattery"] = false,
		["CHudChat"] = false,
		["CHudCrosshair"] = false,
		["CHudGMod"] = false,
		["CHudHealth"] = false,
		["CHudWeaponSelection"] = false,
		["CHudZoom"] = false,
		["NetGraph"] = false,
	},
	hudorder = {
		"CHudHealth",
		"CHudBattery",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudChat",
		"CHudCrosshair",
		"CHudZoom",
		"NetGraph",
		"CHudWeaponSelection",
		"CHudGMod",
	},
	hudtranslations = {
		["CHudAmmo"] = "Ammo (Primary)",
		["CHudSecondaryAmmo"] = "Ammo (Secondary)",
		["CHudBattery"] = "Armor/Battery",
		["CHudChat"] = "Chat (see below)",
		["CHudCrosshair"] = "Default Crosshair",
		["CHudGMod"] = "Lua HUD",
		["CHudHealth"] = "Health",
		["CHudWeaponSelection"] = "Weapon Selection",
		["CHudZoom"] = "+zoom Overlay",
		["NetGraph"] = "net_graph",
	},
	thinktrace = {},
}


-- screenshots and stuff
hook.Add( "HUDShouldDraw", "TylarStools_HudShouldDraw", function( element )

	if tylarstools.hudcomponents[element] then
		return false
	end

end )

local function toggle_hud_element( element )

	if element then
		tylarstools.hudcomponents[element] = not tylarstools.hudcomponents[element]
	end

end

local button_back_color = Color( 52, 52, 52, 255 )
local button_back_color_hover = Color( 72, 72, 72, 255 )
local button_back_color_clicked = Color( 62, 62, 62, 255 )
local button_text_color = Color( 245, 245, 245, 255 )
local button_text_color_hover = Color( 255, 255, 205, 255 )
local button_text_color_clicked = Color( 245, 225, 225, 255 )
local button_green_color = Color( 139, 186, 99, 255 )
local button_red_color = Color( 186, 99, 69, 255 )
local button_blue_color = Color( 55, 139, 186, 255 )

hook.Add( "PopulateToolMenu", "TylarStools_AddScreencapTools", function()
	
	spawnmenu.AddToolMenuOption( "Main", "Render", "icesscreencapclass", "Show/Hide UI", "", "", function( CPanel )
	
		CPanel:AddControl( "Header", { Description = "Show and hide UI elements for screenshots and videos. These changes are temporary and will reset if you leave or rejoin the server that you're currently playing on." } )
		
		for _, component in next, tylarstools.hudorder, nil do
		
			local btn = CPanel:Button( "", "", "" )
				
			if btn then
				
				-- store the component name
				btn.component = component
				btn:SetTooltip( "(" .. component .. ") - " .. ( tylarstools.hudcomponents[component] and "disabled" or "enabled" ) )
				btn:SetText( "" )
				btn:SetHeight( 24 )
				
				-- paint it
				function btn:DoClick()
					
					if tylarstools.hudtranslations[self.component] then
						
						toggle_hud_element( self.component )
						self:SetTooltip( "(" .. self.component .. ") - " .. ( tylarstools.hudcomponents[self.component] and "disabled" or "enabled" ) )
					
					end
					
					surface.PlaySound( "ui/buttonclick.wav" )
				
				end
				
				function btn:Paint( w, h )
					
					local ih = self:IsHovered()
					if tylarstools.hudcomponents[self.component] then
					
						draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_red_color, false, true, false, true )
						draw.SimpleText( tylarstools.characters.cross, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
					else
					
						draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_green_color, false, true, false, true )
						draw.SimpleText( tylarstools.characters.check, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
					end
					
					draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )
					
					draw.SimpleText( tylarstools.hudtranslations[self.component], "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					
				end
			
			end
		
		end
		
		CPanel:AddControl( "Header", { Description = "(Note: if you hit a chat keybind with the Chat element disabled, you might not be able to open the console until you enable Chat again.)" } )
	
	end )
	
	spawnmenu.AddToolMenuOption( "Utilities", "User", "iceshttpclass", "HTTP Request", "", "", function( CPanel )
	
		CPanel:AddControl( "Header", { Description = "Send an HTTP request from your game client." } )
		
		local url_entry = CPanel:TextEntry( "URL", "tylarstools_http_url" )
		local url_cvar = CreateConVar( "tylarstools_http_url", "", FCVAR_NONE, "" )
		
		local request_type = CPanel:ComboBox( "Method", "tylarstools_http_method" )
		request_type:AddChoice( "GET" )
		request_type:AddChoice( "POST" )
		request_type:AddChoice( "HEAD" )
		request_type:AddChoice( "PUT" )
		request_type:AddChoice( "DELETE" )
		request_type:AddChoice( "PATCH" )
		request_type:AddChoice( "OPTIONS" )
		
		local request_type_cvar = CreateConVar( "tylarstools_http_method", "", FCVAR_NONE, "" )
		
		local content_type = CPanel:TextEntry( "Content Type", "tylarstools_http_contenttype" )
		content_type:SetValue( "text/plain; charset=utf-8" )
		local content_type_cvar = CreateConVar( "tylarstools_http_contenttype", "", FCVAR_NONE, "" )
		
		
		
		CPanel:AddControl( "Header", { Description = "\n\nHeaders" } )
		
		local header_key = ""
		local header_value = ""
		local header_index = -1
		
		local headers_list = vgui.Create( "DListView" )
		CPanel:AddItem( headers_list )
		headers_list:SetMultiSelect( false )
		headers_list:AddColumn( "Key" )
		headers_list:AddColumn( "Value" )
		
		local header_key_entry = CPanel:TextEntry( "Key", "tylarstools_header_key" )
		
		local header_value_entry = CPanel:TextEntry( "Value", "tylarstools_header_key" )
		
		headers_list.OnRowSelected = function( lst, index, pnl )
			
			header_index = index
			header_key = pnl:GetColumnText( 1 ) or ""
			header_value = pnl:GetColumnText( 2 ) or ""
			
			header_key_entry:SetValue( header_key )
			header_value_entry:SetValue( header_value )
		
		end
		
		headers_list:SetHeight( 180 )
		
		local add_header_btn = CPanel:Button( "", "", "" )

		if add_header_btn then

			add_header_btn:SetTooltip( "Adds a header to the list." )
			add_header_btn:SetText( "" )
			add_header_btn:SetHeight( 24 )

			-- paint it
			function add_header_btn:DoClick()
				
				local newkey = header_key_entry:GetValue()
				local newvalue = header_value_entry:GetValue()
				
				header_key_entry:SetValue( "" )
				header_value_entry:SetValue( "" )
				
				if not ( ( newkey == "" ) or ( newvalue == "" ) ) then
				
					headers_list:AddLine( newkey, newvalue )
				
				end
				
				surface.PlaySound( "ui/buttonclick.wav" )

			end

			function add_header_btn:Paint( w, h )

				local ih = self:IsHovered()

				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_green_color, false, true, false, true )
				draw.SimpleText( tylarstools.characters.forward, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )

				draw.SimpleText( "Add Header", "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			end

		end
		
		local remove_header_btn = CPanel:Button( "", "", "" )
		
		if remove_header_btn then

			remove_header_btn:SetTooltip( "Removes a header from the list." )
			remove_header_btn:SetText( "" )
			remove_header_btn:SetHeight( 24 )

			-- paint it
			function remove_header_btn:DoClick()
				
				-- remove line by selected rowid
				local line = headers_list:GetSelectedLine() or -1
				
				if line >= 0 then
				
					headers_list:RemoveLine( line )
				
				end
				
				surface.PlaySound( "ui/buttonclick.wav" )

			end

			function remove_header_btn:Paint( w, h )

				local ih = self:IsHovered()

				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_red_color, false, true, false, true )
				draw.SimpleText( tylarstools.characters.forward, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )

				draw.SimpleText( "Remove Header", "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			end

		end
		
		
		
		CPanel:AddControl( "Header", { Description = "\n\nParameters" } )
		
		local param_key = ""
		local param_value = ""
		local param_index = -1
		
		local params_list = vgui.Create( "DListView" )
		CPanel:AddItem( params_list )
		params_list:SetMultiSelect( false )
		params_list:AddColumn( "Key" )
		params_list:AddColumn( "Value" )
		
		local param_key_entry = CPanel:TextEntry( "Key", "tylarstools_param_key" )
		
		local param_value_entry = CPanel:TextEntry( "Value", "tylarstools_param_key" )
		
		params_list.OnRowSelected = function( lst, index, pnl )
			
			param_index = index
			param_key = pnl:GetColumnText( 1 ) or ""
			param_value = pnl:GetColumnText( 2 ) or ""
			
			param_key_entry:SetValue( param_key )
			param_value_entry:SetValue( param_value )
		
		end
		
		params_list:SetHeight( 180 )
		
		local add_param_btn = CPanel:Button( "", "", "" )

		if add_param_btn then

			add_param_btn:SetTooltip( "Adds a parameter to the list." )
			add_param_btn:SetText( "" )
			add_param_btn:SetHeight( 24 )

			-- paint it
			function add_param_btn:DoClick()
				
				local newkey = param_key_entry:GetValue()
				local newvalue = param_value_entry:GetValue()
				
				param_key_entry:SetValue( "" )
				param_value_entry:SetValue( "" )
				
				if not ( ( newkey == "" ) or ( newvalue == "" ) ) then
				
					params_list:AddLine( newkey, newvalue )
				
				end
				
				surface.PlaySound( "ui/buttonclick.wav" )

			end

			function add_param_btn:Paint( w, h )

				local ih = self:IsHovered()

				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_green_color, false, true, false, true )
				draw.SimpleText( tylarstools.characters.forward, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )

				draw.SimpleText( "Add Parameter", "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			end

		end
		
		local remove_param_btn = CPanel:Button( "", "", "" )
		
		if remove_param_btn then

			remove_param_btn:SetTooltip( "Removes a parameter from the list." )
			remove_param_btn:SetText( "" )
			remove_param_btn:SetHeight( 24 )

			-- paint it
			function remove_param_btn:DoClick()
				
				-- remove line by selected rowid
				local line = params_list:GetSelectedLine() or -1
				
				if line > -1 then
				
					params_list:RemoveLine( line )
				
				end
				
				surface.PlaySound( "ui/buttonclick.wav" )

			end

			function remove_param_btn:Paint( w, h )

				local ih = self:IsHovered()

				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_red_color, false, true, false, true )
				draw.SimpleText( tylarstools.characters.forward, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )

				draw.SimpleText( "Remove Parameter", "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			end

		end
		CPanel:AddControl( "Header", { Description = "\n\nResult code" } )
		local result_code_box = vgui.Create( "DTextEntry" )
		CPanel:AddItem( result_code_box )
		CPanel:AddControl( "Header", { Description = "Result headers" } )
		local result_headers_box = vgui.Create( "DTextEntry" )
		CPanel:AddItem( result_headers_box )
		result_headers_box:SetMultiline( true )
		result_headers_box:SetHeight( 80 )
		CPanel:AddControl( "Header", { Description = "Result body" } )
		local result_body_box = vgui.Create( "DTextEntry" )
		CPanel:AddItem( result_body_box )
		result_body_box:SetMultiline( true )
		result_body_box:SetHeight( 180 )
		CPanel:AddControl( "Header", { Description = " " } )
		
		local go_btn = CPanel:Button( "", "", "" )

		if go_btn then
			
			go_btn:SetTooltip( "Make the request." )
			go_btn:SetText( "" )
			go_btn:SetHeight( 24 )

			-- paint it
			function go_btn:DoClick()
				
				result_code_box:SetValue( "" )
				result_headers_box:SetValue( "" )
				result_body_box:SetValue( "" )
				
				local params_tbl = {}
				
				for k,v in next, params_list:GetLines(), nil do
				
					local nk = v:GetColumnText( 1 )
					local nv = v:GetColumnText( 2 )
					
					params_tbl[tostring(nk)] = tostring( nv )
				
				end
				
				local headers_tbl = {}
				
				for k,v in next, headers_list:GetLines(), nil do
				
					local nk = v:GetColumnText( 1 )
					local nv = v:GetColumnText( 2 )
					
					headers_tbl[tostring(nk)] = tostring( nv )
				
				end

				HTTP{
					
					failed = function( reason )
					
						if result_code_box then
						
							result_code_box:SetValue( "request failed" )
							result_headers_box:SetValue( "" )
							result_body_box:SetValue( "" )
						
						end
					
					end,
					
					success = function( code, body, headers )
					
						if result_code_box then
						
							result_code_box:SetValue( tostring( code ) )
							result_headers_box:SetValue( util.TableToKeyValues( headers or {} ) )
							result_body_box:SetValue( body )
						
						end
					
					end,
					
					method = request_type_cvar:GetString() or "GET",
					url = url_cvar:GetString() or "localhost",
					type = content_type_cvar:GetString() or "text/plain; charset=utf-8",
					
					parameters = params_tbl,
					headers = headers_tbl,
					
				}
				
				surface.PlaySound( "ui/buttonclick.wav" )

			end

			function go_btn:Paint( w, h )

				local ih = self:IsHovered()

				draw.RoundedBoxEx( 4, w - h - 4, 0, h + 4, h, button_green_color, false, true, false, true )
				draw.SimpleText( tylarstools.characters.forward, "Marlett", w - ( h / 2 ), h / 2, button_text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.RoundedBoxEx( 4, 0, 0, w - h, h, ih and button_back_color_hover or button_back_color, true, true, true, true )

				draw.SimpleText( "Make Request", "HudHintTextLarge", 8, h / 2, ih and button_text_color_hover or button_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			end
			
			CPanel:AddControl( "Header", { Description = " " } )

		end
	
	end )
	
end )