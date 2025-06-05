local iv = IsValid

tylarstools = {

	cantarget = function( ply, ent, skipfriends ) -- check if a player owns the prop.
		
		if game.SinglePlayer() then return true end
		
		if iv( ply ) and iv( ent ) then
		
			if ent.CPPIGetOwner then -- check if cppi and the getowner function exist
				
				local own = ent:CPPIGetOwner()
				
				if own == ply then -- if so, return if the player owns the prop
				 
					return true
					
				elseif ( not skipfriends ) and own.CPPIGetFriends then
				
					local friends = own:CPPIGetFriends()
					
					for _, friend in next, friends, nil do
					
						if friend == ply then -- entity owner lists the player using the tool as their friend.
						
							return true
						
						end
					
					end
				
				end
			
			else -- no prop protection installed, we've gotta go through g_SBoxObjects.
			
				for k, v in next, g_SBoxObjects[ply:UniqueID()], nil do
				
					for _, found_ent in next, v, nil do
					
						if ent == found_ent then
						
							return true
							
						end
						
					end
					
				end
			
			end
		
		end
		
		return false -- default to false unless the specific conditions are met
	
	end,
	
}