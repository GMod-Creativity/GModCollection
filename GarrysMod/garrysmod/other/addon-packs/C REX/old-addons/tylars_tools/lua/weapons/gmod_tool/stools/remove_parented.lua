local iv = IsValid
local Color = Color
local clamp = math.Clamp
local utl = util.TraceLine
local ugpt = util.GetPlayerTrace

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

REMPARENT_LEFT = 0
REMPARENT_RIGHT = 1
REMPARENT_RELOAD = 2

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Construction"
TOOL.Name = "Remove Parented"
TOOL.Command = nil
TOOL.ConfigName = nil

TOOL.ClientConVar[ "r" ] = 255
TOOL.ClientConVar[ "g" ] = 255
TOOL.ClientConVar[ "b" ] = 255
TOOL.ClientConVar[ "a" ] = 255
TOOL.ClientConVar[ "mode" ] = "0"
TOOL.ClientConVar[ "fx" ] = "0"
TOOL.ClientConVar[ "ccrf" ] = "0"

if CLIENT then

	language.Add( "tool.remove_parented.name", "Remove Parented Props" )
	language.Add( "tool.remove_parented.desc", "Remove entites and/or constraints on entities regardless of parent/child status." )
	language.Add( "tool.remove_parented.help", "This is a rewritten remover tool that allows you to remove any entity, regardless of its parent/child status, meaning parented props can be removed without accidentally removing the parent itself." )
	language.Add( "tool.remove_parented.left", "Remove an entity" )
	language.Add( "tool.remove_parented.right", "Remove and entity and anything constrained to it (weld, nocollide, rope, etc.)" )
	language.Add( "tool.remove_parented.reload", "Strip an entity of its constraints." )
	
end

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" },
}

if SERVER then

	util.AddNetworkString( "icetools_remove_parented_docapture" )
	util.AddNetworkString( "icetools_remove_parented_doachievement" )
	util.AddNetworkString( "icetools_remove_parented_capentity_left" )

end

-- left and right click

local mode = {}
local expect = {}

if SERVER then

	net.Receive( "icetools_remove_parented_capentity_left", function( len, ply )
	
		local ent = net.ReadEntity()

		if iv( ply ) and iv( ent ) then
			
			local sid = ply:SteamID()
			
			if expect[sid] and mode[sid] and not ( ent:IsPlayer() ) then
				
				local selected_mode = mode[sid]
				expect[sid] = false
				mode[sid] = false
				
				if tylarstools.cantarget( ply, ent ) then
				
					if selected_mode == REMPARENT_LEFT then
					
						-- code from remover tool:
						constraint.RemoveAll( ent )
						timer.Simple( 1, function()
						
							if iv( ent ) then
							
								SafeRemoveEntity( ent ) -- function ships with gmod
							
							end
						
						end )
						
						ent:SetNotSolid( true )
						ent:SetMoveType( MOVETYPE_NONE )
						ent:SetNoDraw( true )
						
						local ed = EffectData()
						ed:SetOrigin( ent:GetPos() )
						ed:SetEntity( ent )
						util.Effect( "entity_remove", ed, true, true )
						-- end code from remover tool
						
						-- make sure to give the player the remover achievement... without SendLua this time
						net.Start( "icetools_remove_parented_doachievement" )
						net.Send( ply )
					
					elseif selected_mode == REMPARENT_RELOAD then
					
						constraint.RemoveAll( ent )
					
					elseif selected_mode == REMPARENT_RIGHT then
					
						local constrained_entities = constraint.GetAllConstrainedEntities( ent )
						
						for _, cent in next, constrained_entities, nil do
						
							if iv( cent ) then
								
								constraint.RemoveAll( cent )
								timer.Simple( 1, function()
								
									if iv( cent ) then
									
										SafeRemoveEntity( cent ) -- function ships with gmod
									
									end
								
								end )
								
								cent:SetNotSolid( true )
								cent:SetMoveType( MOVETYPE_NONE )
								cent:SetNoDraw( true )
								
								local ed = EffectData()
								ed:SetOrigin( cent:GetPos() )
								ed:SetEntity( cent )
								util.Effect( "entity_remove", ed, true, true )
							
							end
						
						end
					
					end
				
				end
			
			end
		
		end
	
	end )

end

if CLIENT then

	-- get the capture
	net.Receive( "icetools_remove_parented_docapture", function( len )

		local trace = utl( ugpt( LocalPlayer() ) )
		
		if iv( trace.Entity ) then
		
			net.Start( "icetools_remove_parented_capentity_left" )
				net.WriteEntity( trace.Entity )
			net.SendToServer()
		
		end
	
	end )
	
	-- make sure people get the achievement
	net.Receive( "icetools_remove_parented_doachievement", function( len )
	
		achievements.Remover()
	
	end )

end

function TOOL:LeftClick( trace )
	
	if SERVER then
	
		local own = self:GetOwner()
		
		if iv( own ) then
		
			local sid = own:SteamID()
			
			mode[sid] = REMPARENT_LEFT
			expect[sid] = true
			
			net.Start( "icetools_remove_parented_docapture" )
			net.Send( own )
			
			return true
		
		end
	
	else
	
		return true
	
	end
	
	return false

end

function TOOL:RightClick( trace )
	
	if SERVER then
	
		local own = self:GetOwner()
		
		if iv( own ) then
		
			local sid = own:SteamID()
			
			mode[sid] = REMPARENT_RIGHT
			expect[sid] = true
			
			net.Start( "icetools_remove_parented_docapture" )
			net.Send( own )
			
			return true
		
		end
	
	else
	
		return true
	
	end
	
	return false

end

function TOOL:Reload( trace ) -- hue
	
	if SERVER then
	
		local own = self:GetOwner()
		
		if iv( own ) then
		
			local sid = own:SteamID()
			
			mode[sid] = REMPARENT_RELOAD
			expect[sid] = true
			
			net.Start( "icetools_remove_parented_docapture" )
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

	CPanel:AddControl( "Header", { Description = "#tool.remove_parented.help" } )


end

