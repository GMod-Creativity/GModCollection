/******************************************************************************\
  XSound (Extended sound)
\******************************************************************************/

E2Lib.RegisterExtension( "xtrasound", true,
	"Supplemental sound extension functionality. Includes every CSoundPatch function not covered in the default sound extension.",
	"Sounds can be played out of arbitrary entities, including other players."
)

-- Cache local refs to globals
local CreateConVar = CreateConVar
local CreateSound = CreateSound
local SoundDuration = SoundDuration
local IsValid = IsValid
local isnumber = isnumber
local next = next
-- Library references
local blshift = bit.lshift
local fExists = file.Exists
local fOpen = file.Open
local mabs = math.abs
local mClamp = math.Clamp
local mfloor = math.floor
local mRound = math.Round
local ssub = string.sub 
local tExists = timer.Exists
local tCreate = timer.Create
local tRemove = timer.Remove
local tSimple = timer.Simple

-- Cache common sound convars
local wire_expression2_maxsounds = CreateConVar( "wire_expression2_maxsounds", 16, {FCVAR_ARCHIVE} )
local wire_expression2_sound_burst_max = CreateConVar( "wire_expression2_sound_burst_max", 8, {FCVAR_ARCHIVE} )
local wire_expression2_sound_burst_rate = CreateConVar( "wire_expression2_sound_burst_rate", 0.1, {FCVAR_ARCHIVE} )
-- Convars we have added
-- _level_max: Sets the maximum soundLevel we can set on a sound. 140 is maximum to begin with, a more non-obnoxious level is maybe around 110.
local wire_expression2_sound_level_max = CreateConVar( "wire_expression2_sound_level_max", 140, {FCVAR_ARCHIVE} )

-- Gets the CSoundPatch ent at the given index
local resolve = function( self, idx )
	return self.data.sound_data.sounds[idx] -- eureka
end

-- Apr 22 2021: add missing compatibility functions local in sound extension https://github.com/wiremod/wire/blob/master/lua/entities/gmod_wire_expression2/core/sound.lua#L15
local function isAllowed( self )
	local data = self.data.sound_data
	local count = data.count
	if count == wire_expression2_maxsounds:GetInt() then return false end
	if data.burst == 0 then return false end
	data.burst = data.burst - 1

	local timerid = "E2_sound_burst_count_" .. self.entity:EntIndex()
	if not tExists( timerid ) then
		tCreate( timerid, wire_expression2_sound_burst_rate:GetFloat(), 0, function()
			if not IsValid( self.entity ) then
				tRemove( timerid )
				return
			end
			data.burst = data.burst + 1
			if data.burst == wire_expression2_sound_burst_max:GetInt() then
				tRemove( timerid )
			end
		end )
	end

	return true
end

local soundStop
soundStop = function( self, index, fade )
	local sound = resolve( self, index )
	if not sound then return end
	fade = mabs( fade )
	if fade == 0 then
		sound:Stop()
		if isnumber( index ) then index = mfloor( index ) end
		self.data.sound_data.sounds[index] = nil
		self.data.sound_data.count = self.data.sound_data.count - 1
	else
		sound:FadeOut( fade )

		tSimple( fade, function() soundStop( self, index, 0 ) end)
	end

	timer.Remove( "E2_sound_stop_" .. self.entity:EntIndex() .. "_" .. index )
end
-- end Apr 22 2021

-- If idx is a number, returns its floor, else returns original
local normIndex = function( idx )
	if isnumber( idx ) then 
		return mfloor( idx )
	end
	return idx
end

-- Returns correct path on the filesystem
local normPath = function( path )
	return path:Trim():gsub( "\\", "/" )
end

-- used in playSoundEX - derived from the original soundCreate function (which is local in the original extension >:( )
local soundCreateEX = function( self, entity, idx, time, path, fade, volume, pitch )
	if path:match( '["?]' ) then return end
	local data = self.data.sound_data
	if not isAllowed( self ) then return end
	
	path = normPath( path )
	idx = normIndex( idx )
	local timerid = "E2_sound_stop_" .. self.entity:EntIndex() .. "_" .. idx
	
	local sound = resolve( self, idx )
	if sound then 
		sound:Stop()
		tRemove( timerid )
	else data.count = data.count + 1 end
	
	local filter = RecipientFilter()
	filter:AddAllPlayers() -- network the sound to all players
	local sound = CreateSound( entity, path, filter )
	data.sounds[idx] = sound 
	sound:PlayEx( volume, pitch )
	
	entity:CallOnRemove( "E2_stopsound", function()
		soundStop( self, idx, 0 )
	end )
	
	if ( time == 0 ) and ( fade == 0 ) then 
		return 
	end
	time = mabs( time )
	
	tCreate( timerid, time, 1, function()
		if ( not self ) or ( not IsValid( self.entity ) ) or ( not IsValid( entity ) ) then 
			return
		end
		soundStop( self, idx, fade )
	end )
end

-- End helpers

----------------------------------------------------
-- soundLevel, soundDSP (Monkatraz)
----------------------------------------------------

__e2setcost(5)

e2function void soundDSP( index, dsp )
	local sound = resolve( self, index )
	if not sound then return end
	-- We need to apply the DSP while the sound is stopped
	sound:Stop()
	sound:SetDSP( mClamp( dsp, 0, 34 ) ) -- clamped up to 34 because anything past 34 produces the sound of the letter E
	sound:Play()
end
e2function void soundDSP( string index, dsp ) = e2function void soundDSP( index, dsp )

e2function void soundLevel( index, level )
	local sound = resolve( self, index )
	if not sound then return end
	-- We need to set the level while the sound is stopped
	sound:Stop()
	sound:SetSoundLevel( mClamp( level, 0, wire_expression2_sound_level_max:GetInt() ) )
	sound:Play()
end
e2function void soundLevel( string index, level ) = e2function void soundLevel( index, level )

----------------------------------------------------
-- Other stuff (Tim)
----------------------------------------------------

__e2setcost(15)

-- Tells us if a sound with the given path exists anywhere in any workshop or legacy addon
e2function number soundExists( string path )
	if path:match( '["?]' ) then return 0 end
	path = normPath( path )
	if ssub( path, 1, 6 ) ~= "sound/" then path = "sound/" .. path end
	if fExists( path, "GAME" ) then return 1 end 
	return 0
end

__e2setcost(25)

-- playex (playSound, but allows for setting volume+pitch directly)

e2function void soundPlayEX( index, duration, string path, volume, pitch )
	soundCreateEX( self, self.entity, index, duration, path, 0, volume, pitch )
end
e2function void soundPlayEX( string index, duration, string path, volume, pitch ) = e2function void soundPlayEX( index, duration, string path, volume, pitch )

e2function void entity:soundPlayEX( index, duration, string path, volume, pitch )
	if not IsValid( this ) or not isOwner( self, this ) then return end
	soundCreateEX( self, self.entity, index, duration, path, 0, volume, pitch )
end
e2function void entity:soundPlayEX( string index, duration, string path, volume, pitch ) = e2function void entity:soundPlayEX( index, duration, string path, volume, pitch )

e2function void entity:soundPlayEX( index, duration, string path, fade, volume, pitch )
	if not IsValid( this ) or not isOwner( self, this ) then return end
	soundCreateEX( self, self.entity, index, duration, path, fade, volume, pitch )
end
e2function void entity:soundPlayEX( string index, duration, string path, fade, volume, pitch ) = e2function void entity:soundPlayEX( index, duration, string path, fade, volume, pitch )

e2function void soundPlayEX( index, duration, string path, fade, volume, pitch )
	soundCreateEX( self, self.entity, index, duration, path, fade, volume, pitch )
end
e2function void soundPlayEX( string index, duration, string path, fade, volume, pitch ) = e2function void soundPlayEX( index, duration, string path, fade, volume, pitch )

-- GETs for the above

__e2setcost(2)

e2function number soundDSP( index )
	local sound = resolve( self, index )
	if not sound then return 0 end
	return sound:GetDSP() or 0
end
e2function number soundDSP( string index ) = e2function number soundDSP( index )

e2function number soundLevel( index )
	local sound = resolve( self, index )
	if not sound then return 0 end
	return sound:GetSoundLevel()
end
e2function number soundLevel( string index ) = e2function number soundLevel( index )

-- Extras (GETs)

e2function number soundPitch( index )
	local sound = resolve( self, index )
	if not sound then return 0 end
	return sound:GetPitch()
end
e2function number soundPitch( string index ) = e2function number soundPitch( index )

e2function number soundVolume( index )
	local sound = resolve( self, index )
	if not sound then return 0 end
	return sound:GetVolume()
end
e2function number soundVolume( string index ) = e2function number soundVolume( index )

e2function number soundPlaying( index )
	local sound = resolve( self, index )
	if not sound then return 0 end
	return sound:IsPlaying() and 1 or 0
end
e2function number soundPlaying( string index ) = e2function number soundPlaying( index )

-- Patched SoundDuration thing

__e2setcost(5)

-- Finds the length of a .wav file in seconds, rounded to 3 decimal places
--  - If on Windows, this will use the standard SoundDuration function, since it works on Windows just fine
--  - On Linux, since SoundDuration returns 0, it reads the header and returns DataLen / ( SampleRate * NumChannels * BitsPerSample/8 ) as the length in seconds
-- Denominator is encoded in header as ByteRate (ULong at offset 28)
-- Returns 0 if: (Windows: SoundDuration returns nil or 0), (Linux/Mac: file is locked, file length is less than 44 bytes, or if ByteRate or DataLen was 0)
-- Will revert to the imprecise method of file:Size() - 44 if the length from the header looks wrong

-- offsets for wav header 
local WAV_OFFSET_BYTERATE = 28 -- SampleRate * NumChannels * BitsPerSample/8
local WAV_OFFSET_SUBCHUNK1SIZE = 16 -- =0x0F for PCM
local WAV_OFFSET_SUBCHUNK2SIZE = 40 -- If PCM, 40. Else, need to offset by + (SubChunk1Size - 4)

-- read 4 bytes and return number value (little-endian)
local read4 = function( f, offset ) -- little-endian
	if f == nil then return 0 end
	local br = {0,0,0,0}
	f:Seek( offset )
	local i
	for i = 1, 4 do 
		if not f:EndOfFile() then br[i] = f:ReadByte() else br[i] = 0 end
	end
	return blshift( br[4], 24 ) + blshift( br[3], 16 ) + blshift( br[2], 8 ) + br[1]
end

-- calculates the length of the wav
local wavLen = function( path )
	f = fOpen( path, "rb", "GAME" )
	if f == nil then return 0 end
	if f:Size() < 44 then return 0 end
	local SubChunk1Size = read4( f, WAV_OFFSET_SUBCHUNK1SIZE )
	local ByteRate = read4( f, WAV_OFFSET_BYTERATE )
	if ByteRate == 0 then f:Close() return 0 end
	local DataLen = read4( f, WAV_OFFSET_SUBCHUNK2SIZE + ( SubChunk1Size == 16 and 0 or SubChunk1Size - 4 ) )
	if DataLen <= 64 then --[[ dont care didnt ask plus your jazzlok ]] DataLen = f:Size() - 44 end
	f:Close()
	return DataLen / ByteRate
end

e2function number soundDurationFix( string path )
	if ssub( path, -4 ) ~= ".wav" then return SoundDuration( path ) or 0 end
	if system.IsWindows() then
		return SoundDuration( path ) or 0
	end
	-- we're on posix now, hello 2 percenter
	if path:match( '["?]' ) then return 0 end
	path = normPath( path )
	if ssub( path, 1, 6 ) ~= "sound/" then path = "sound/" .. path end
	return wavLen( path )
end

e2function number soundDurationFix( string path, forceReadHeader )
	if ssub( path, -4 ) ~= ".wav" then return SoundDuration( path ) or 0 end
	if system.IsWindows() and not ( forceReadHeader == 1 ) then
		return SoundDuration( path ) or 0
	end
	-- we're on posix now, hello 2 percenter
	if path:match( '["?]' ) then return 0 end
	path = normPath( path )
	if ssub( path, 1, 6 ) ~= "sound/" then path = "sound/" .. path end
	return wavLen( path )
end