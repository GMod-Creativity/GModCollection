- Author: thewhitish
- YouTube: https://www.youtube.com/@nathansmith9820
- YouTube: https://www.youtube.com/@thewhitish
<!-- -->
- Title: personal countermeasure suite, universal prop shooter, energetic area denial, more
- Date (dd-mm-yyyy): 26-03-2015
- Source: https://web.archive.org/web/20150419052849/http://www.wiremod.com:80/forum/finished-contraptions/34219-personal-countermeasure-suite-universal-prop-shooter-energetic-area-denial-more.html
- Source Accessed (dd-mm-yyyy): 29-08-2025

## Assorted E2s

https://web.archive.org/web/20161213141525/https://www.youtube.com/watch?v=zgcqvjfOxig

I am become death, the enabler of minges

=====================personal countermeasure suite==============

    This script will try to protect the owner from other player's sweps. The chip itself will try to intercept the bullet by moving in front of it.

    It won't get in the way of the owners movement, and is more effective at stopping penetration than my previous shield.

    It doesn't need propcore at all, although there is a version with propcore that is more effective (especially against multiple targets).

    It is mostly effective against sniper shots. it doesn't deal with situations involving full auto fire with both parties bunny hopping and strafing very well.

    It also has a jam mode, which puts the chip right in front of the attackers shoot position. This is less effective than you would think, and much less effective than normal when there are multiple assailants (without propcore's setpos() that is).

    The propcore version also has a reciprocate mode that will kill anyone that tries to shoot you.

    Credit to [Paper Clip](https://web.archive.org/web/20150419052849/http://www.wiremod.com/forum/members/paper-clip.html) for inspiration regarding the vector math

=====================energetic area denial==============

    A dupe that ignites things in a 600 unit radius when you turn it on. I could have used more holos, but it needs an igniter anyway.

=====================propcore based admin chip==============

    This script has probably been done before, and better, but it was burning a hole in my e2 folder so here it is.

    slap, blind, freeze (if noclip is disabled), and kill players through chat.

    type /kill playername

    or /blind playername, or /freeze playername, etc

    /clear will reset all freezing props and blinding holos

=====================universal prop shooter==============

    This script is not quite as no-assembly-required as my others. This is more of a builders tool.

    It is highly configurable, and can be easily reprogrammed to fire many different types of projectiles at different rates at different targets, from the chip, the player, or whatever craft the chip is placed on. It supports burst fire, explosive rounds, and reloading. It can be operated from a key, or via wire input. It can be used in place of a door gun, tank turret, or swep very easily.

    It will detect when the projectile has fulfilled its duty and clean up after itself. It also keeps track of its ops and has a soft limit built in. In general it tends to all the housekeeping required when a script is trying to spawn a bunch of props all at once.

    Modes can be switched from chat, and you can easily make your own presets.

    Many will see this as pointless when mods like pewpew, or gcombat, or whatever the lua people are using nowadays, exists. I would have to agree, but personally I feel such things are cheating.

    It uses propcore obviously.

    GAU sound made possible by WAC aircraft
