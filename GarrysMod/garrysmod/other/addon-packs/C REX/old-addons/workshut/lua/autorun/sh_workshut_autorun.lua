Workshut = {}
local IsValid = IsValid 
local clamp = math.Clamp
local DEBUG_FAKE_BEING_DEDICATED = true -- set to true to develop on singleplayer/listen server (PRODUCTION: set false)

if SERVER then 
	util.AddNetworkString( "Workshut_SyncIsDedicated" )
	util.AddNetworkString( "Workshut_NoPermission" )
	local isDedicated = DEBUG_FAKE_BEING_DEDICATED or game.IsDedicated()
	
	-- Sync value of isDedicated when player spawns
	hook.Add( "PlayerInitialSpawn", "Workshut_PlayerInitialSpawn", function( ply )
		net.Start( "Workshut_SyncIsDedicated" )
			net.WriteBool( isDedicated )
		net.Send( ply )
	end )
	
	-- redirect duplicator.Paste (just in case).
	local oduplicatorPaste = duplicator.Paste
	if isDedicated then
		duplicator.Paste = function( ply, entlist, conlist ) return {}, {}; end
	end
	
	hook.Add( "CanTool", "Workshut_CanTool_SV", function( ply, tr, tool )
		if tool == "duplicator" then 
			-- Only deny if system enabled
			if isDedicated then
				net.Start( "WorkShut_NoPermission" )
				net.Send( ply )
				return false
			end
			
		end
	end )
	
end

if CLIENT then 
	local client_language = ""
	local cache_language = function()
		local phrase_table = {
			["Refresh"] = "en",
			["Обновить"] = "ru",
			["Oppdater"] = "no",
			["Actualizar"] = "es",
			["Actualizar"] = "es-ES",
			["Opdater"] = "da",
			["Vernieuwen"] = "nl",
			["Aktualisieren"] = "de",
			["Actualiser"] = "fr",
			["새로 고침"] = "ko",
		}
		client_language = phrase_table[language.GetPhrase("refresh")] or "en"
	end 

	local isDedicated = true -- game.IsDedicated() returns false on client always, so just send the value down.
							 -- Defaults to true just in case.
	local addNotify = notification.AddLegacy
	local playSound = surface.PlaySound
	
	-- Shows the Sandbox notifictation and plays the sound
	Workshut.ShowDeniedNotification = function()
		if client_language == "" then
			cache_language()
		end
		print( "Duplicator denied" )
		addNotify( Workshut.DenyLanguage[client_language] or Workshut.DenyLanguage.en, 1, 4 )
		playSound( "common/wpn_denyselect.wav" )
	end
	
	-- Disable the Dupes and Saves tabs if the system is enabled (dedicated server?)
	-- Also, disable spawnmenu.ActivateTool for "duplicator" if enabled 
	-- 		player will see the denied notification when they click on Duplicator in the tool list;
	-- 		gmod_tool command looks like it switches to duplicator but doesn't activate context menu
	local oAddCreationTab = spawnmenu.AddCreationTab
	Workshut.DoClientRedirects = function()
		if isDedicated then
			local tabs = spawnmenu.GetCreationTabs()
			tabs["#spawnmenu.category.dupes"] = nil 
			tabs["#spawnmenu.category.saves"] = nil 
			spawnmenu.AddCreationTab = function( name, cback, icon, wt )
				if ( name ~= "#spawnmenu.category.dupes" ) and ( name ~= "#spawnmenu.category.saves" ) then 
					oAddCreationTab( name, cback, icon, wt )
				end
			end
			RunConsoleCommand( "spawnmenu_reload" )
		end
	end
	
	-- String to show in the notification upon denial of Duplicator tool - translators listed :)
	Workshut.DenyLanguage = {
		en = "The Workshop and the Duplicator tool are disabled on this server.", -- Me
		ru = "Вы не можете сделать это.", -- Me ("You cannot do this")
		no = "Workshop og Duplikator er deaktivert på denne server.", -- Me, might need work, not sure
		es = "La Workshop y el Duplicador están desactivados en este servidor.", -- NoFrankRelax
		["es-ES"] = "La Workshop y el Duplicador están desactivados en este servidor.", -- NoFrankRelax
		da = "Workshop og Duplikator er deaktiveret på denne server.", -- Sadogus
		nl = "De Workshop en Duplicator tools zijn ge-disabled op onze server.", -- DaRustyrail
		de = "Der Workshop und der Duplikator sind auf diesem Server deaktiviert.", -- Anyone999991
		fr = "Vous n'êtes pas autorisé à le faire.", -- Need better translation (~"You are not allowed to do this")
		ko = "작업을 수행 할 수 없습니다", -- Need better translation (~"This operation cannot be performed")
	}
	
	net.Receive( "Workshut_NoPermission", function( l ) print( "AAA" ) Workshut.ShowDeniedNotification() end )
	net.Receive( "Workshut_SyncIsDedicated", function( l )
		local b = net.ReadBool()
		isDedicated = b or DEBUG_FAKE_BEING_DEDICATED
		Workshut.DoClientRedirects()
	end )
	
	hook.Add( "CanTool", "Workshut_CanTool_CL", function( ply, tr, tool )
		if tool == "duplicator" then 
			-- Only deny if system enabled
			if isDedicated then
				return false
			end
		end
	end )

end

-- SHARED 
-- Add CanTool hook for "duplicator"

