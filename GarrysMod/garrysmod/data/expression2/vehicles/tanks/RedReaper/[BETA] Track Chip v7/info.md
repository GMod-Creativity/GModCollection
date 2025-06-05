Author: RedReaper
Date: 10-27-2014
Title: [BETA] Track Chip v7

This is a beta of release of my track chip, a new version which is a total rewrite. It is still being worked on. To-dos are minor efficiency enhancements, and possibly writing a plugin with the camo chip to recolor treads based off terrain (like grass terrain will make your tracks green a bit from ripping up grass, etc).

If you don't know what this is, it is a system which creates holographic tank treads which follow your road wheels. This makes tanks and other track vehicles more realistic looking.
This is a vid with an old version in action.

https://www.youtube.com/watch?v=U4-j4Cu0wtE

New features include rounded track edges, the ability to stretch the first and last track links so that they don't clip wheels, and support for uneven-size road wheels. It also has included support for trailing idlers and return rollers. It also adds support for being automatically updated (@autoupdate), so that your vehicles can always be on the latest version.

To use it is like my previous versions, spawn an advanced entity marker and link to it the first road wheel, second one, etc, through to the last one. Repeat this for other tracks. We'll do the same thing for return rollers if applicable, starting with the first one at the front and ending with the one closest to the rear.

Current Known Issues:
Op count is absurdly high due to wire counting indexing an array as 10 ops. I have no idea why wire counts it as that, but indexing a var as 1 op. That has nothing to do with actual lag or performance, CPU load isn't that high.
It occasionally spams a "function undefined at runtime" error on dupe, just reset the chip. That's e2 for ya.
"Static" chat command is basically non-functional, it will be fixed in near future. Don't use it or the var yet. Just change int to like 50000
If you link over 20 wheels it'll argue with you, as it should. Turdlord.

Technical mumbo-jumbo for people who mod e2s: this is a lot easier to use, I switched to calling functions and using array indexes instead of direct hard-coding. About time. I have a list of the holo indexes too, it should support in theory about 48 wheels and 24 return rollers per track. I optimized the slack-track run, to if applicable copy track angling via persistence to save op load.

The goods.

You'll have to copy and paste "Adv_Track_Chip.txt" into your gmod e2 folder

"VarLib.txt" is the variable library. You spawn this chip and update it on your vehicle, and link it to the main track chip. This way when the track chip auto-updates, it always gets the right variables.
