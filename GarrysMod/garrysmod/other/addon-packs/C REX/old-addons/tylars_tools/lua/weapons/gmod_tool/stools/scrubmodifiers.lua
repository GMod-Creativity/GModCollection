local iv = IsValid

-- TOOL.Tab = "tylarstools"
TOOL.Category = "Construction"
TOOL.Name = "Scrub Modifiers"
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

	language.Add( "tool.scrubmodifiers.name", "Scrub Entity Modifiers" )
	language.Add( "tool.scrubmodifiers.desc", "Remove all of an entity's dupe modifiers." )
	language.Add( "tool.scrubmodifiers.help", "Removing all of an entity's dupe modifiers means that when the entity is duped, it will not retain the properties it had before it was copied. This makes the duplicator and advanced dupe tools forget things like the entity's color, material, buoyancy ratio, mass override, and etc." )
	language.Add( "tool.scrubmodifiers.left", "Scrub an entity's dupe modifiers" )
	
end

TOOL.Information = {
	{ name = "left" },
}

function TOOL:LeftClick( trace ) -- modify
	
	if SERVER then
	
		local ent = trace.Entity
		local own = self:GetOwner()
		
		if iv( ent ) and iv( own ) then
			
			if tylarstools.cantarget( own, ent ) then
				
				if ent.EntityMods then
				
					ent.EntityMods = nil

					local eff = EffectData()
					eff:SetOrigin( ent:GetPos() )
					eff:SetEntity( ent )
					util.Effect( "propspawn", eff, true, true )

					return true
				
				end
			
			end
		
		end
		
		return false
	
	end
	
	return true

end

function TOOL:RightClick( trace )
	
	return true

end

-- reload and holster should stay empty

function TOOL:Reload( trace )

end

function TOOL:Holster()

end


-- right side panel list

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.scrubmodifiers.help" } )


end