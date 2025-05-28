Author: RedReaper

*Ferv & Red's Coloring/Camo Chip v2*

If you've been on FRS recently, you know what this chip does. If not, watch and learn.
https://www.youtube.com/watch?v=7bOQGDiSymY

The simple
This chip allows you to change the coloring of a vehicle in realtime, easily, with a single chat command. It makes

into

with a single chat command.
This is useful for tanks (terrain or team color schemes), aircraft (squadron colors), or cars (blue, red, green, yellow, black). It is stunningly easy to use as well. It basically does what smartpainter did automatically.

The technical for nerds
The chip scans through constrained entities, and sorts them based off of color, saving them into arrays. These arrays are in turn colored off the camo scheme selected's entry. Simple yet ingenious. It produces no lag or real cpu use when idle either.

How to use it
To set a vehicle up for it, you should color the vehicle's parts like in my first picture. Red, blue, yellow, and orange parts are retextured and recolored from the preset schemes. Green and purple are recolored, but not retextured--ideal for detail props or things like wheels. Then spawn the chip on the vehicle. It is now set up, and you can save.

To use it, type "camo (name of your camo goes here)". So an example would be "camo blue" to recolor into my blue camo scheme.

To add your own schemes, there is a template inside. You can copy and paste it into a dedicated area, and adjust its variables to your liking. You should make several camo schemes yourself, which you can do off your old contraptions' colors. It has the ability to apply 4 main colors and 2 non-textured colors, so even six-tone camo is possible, meaning that subtler shading is still possible.

To convert an old vehicle to this is VERY simple. Simply attach the chip somehow (usually a parent), and use smartpainter or colormater to adjust camo on the old one to the colors this one detects. You can program in with the template with zero e2 knowledge the new schemes.

Note: if you do not have parts of your shit nocollided, it will not detect it. There is NO reason not to have nocollides between parented stuff on your vehicles anyway.

Credits
The original version of this chip, and tbh all the hard stuff, was done by Fervidusletum/Damnation. My role was more getting it into a more user-friendly form, convincing ferv that it's worth releasing, doing stuff like like changing the prefix coding, coding in preexisting camos, the "template" idea, etc. I also added 3 channels, as it was originally just red/blue/green. That being said I could probably rewrite it, since, seeing this chip inspired me to learn how it worked and in turn inspired a lot of my recent code projects. So it's really 99% ferv and me just puking rainbows on his code for him. But it was released with his blessing.