# Expression 2 - [Lemongate] MIDI Player (not another one!)

## Details

### Author

- Author: TheFreezebug
- Steam Profile: https://steamcommunity.com/profiles/76561198007934416
- Github: https://github.com/TheFreezebug

### Publication Info

- Title: [Lemongate] MIDI Player (not another one!)
- Date (dd-mm-yyyy): 16-02-2014
- Source: https://web.archive.org/web/20150429005650/http://www.wiremod.com:80/forum/finished-contraptions/32740-lemongate-midi-player-oh-god-not-another-one.html
- Source Accessed (dd-mm-yyyy): 14-08-2025

## Description

Heya :P, here is my second contraption.

Its yet another MIDI player, that *sigh*, yes, runs off of PHP.

Though I took advantage of lemongate's abundance of resources to make this.

I understand its rather messy and undocumented, but either way, enjoy.

### EDIT:

My server is included within the lemon, and will continue to be up until i decide to stop paying the bill, or until you guys mess it up by sending so many requests :P

### LEMON CODE

lgmidi.php (OPTIONAL, only if you're running the script off of your own server).

mc.php (Optional, only if your running it off of your own server)
(THIS IS JUST A MODIFIED MIDI CLASS, BE WARNED. IT IS LARGE)

### Commands:

```
set 
     > Arguments:
       ta <number> | Adds <number> to the timebase, then restarts the song.
       fd <number> | Divides the frequency of the notes by <number>

invoke 
       >Arguments:
        halt | Resets nearly every variable in the chip without reloading
        restart | restarts the current song playing

pause | Pauses the current song (Unfinished)
continue | Continues the current song (Unfinished)

mute <number> | Mutes the specified channel.

unmute <number> | Unmutes the specified channel.
```

That's about it,

Credits are within the gate.

I figured i'd do something rather interesting for my first lemongate ( but that doesn't imply it has to be organized, I'm normally very picky about organization x.x)
