E2Helper.Descriptions["soundDSP(nn)"] = "Sets the DSP effect for the sound at the index, then restarts the sound"
E2Helper.Descriptions["soundDSP(sn)"] = "Sets the DSP effect for the sound at the index, then restarts the sound"
E2Helper.Descriptions["soundLevel(nn)"] = "Sets the sound's level in dB, then restarts the sound. This affects how far away the sound can be heard."
E2Helper.Descriptions["soundLevel(sn)"] = "Sets the sound's level in dB, then restarts the sound. This affects how far away the sound can be heard."
E2Helper.Descriptions["soundPlayEX(nnsnn)"] = "Like soundPlay, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(snsnn)"] = "Like soundPlay, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(e:nnsnn)"] = "Like soundPlay, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(e:snsnn)"] = "Like soundPlay, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(nnsnnn)"] = "Like soundPlay w/fade, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(snsnnn)"] = "Like soundPlay w/fade, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(e:nnsnnn)"] = "Like soundPlay w/fade, but with volume and pitch"
E2Helper.Descriptions["soundPlayEX(e:snsnnn)"] = "Like soundPlay w/fade, but with volume and pitch"
E2Helper.Descriptions["soundDSP(n)"] = "Returns the DSP effect for the sound at the index (default 0)"
E2Helper.Descriptions["soundDSP(s)"] = "Returns the DSP effect for the sound at the index (default 0)"
E2Helper.Descriptions["soundLevel(n)"] = "Returns the sound level in dB for the sound at the index"
E2Helper.Descriptions["soundLevel(s)"] = "Returns the sound level in dB for the sound at the index"
E2Helper.Descriptions["soundPitch(n)"] = "Returns the pitch of the sound at the index"
E2Helper.Descriptions["soundPitch(s)"] = "Returns the pitch of the sound at the index"
E2Helper.Descriptions["soundVolume(n)"] = "Returns the volume of the sound at the index"
E2Helper.Descriptions["soundVolume(s)"] = "Returns the volume of the sound at the index"
E2Helper.Descriptions["soundPlaying(n)"] = "Returns 1 if the sound at the index is playing, 0 if not"
E2Helper.Descriptions["soundPlaying(s)"] = "Returns 1 if the sound at the index is playing, 0 if not"
E2Helper.Descriptions["soundDurationFix(s)"] = "OS-safe .wav length - uses SoundDuration to get .wav length on Windows; reads bytes from header to calculate .wav length on Linux/Mac"
E2Helper.Descriptions["soundDurationFix(sn)"] = "soundDurationFix but with an extra boolean to force Windows to use the read-header method intended for Linux/Mac"