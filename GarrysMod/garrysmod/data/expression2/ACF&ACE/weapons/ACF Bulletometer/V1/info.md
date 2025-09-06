# Expression 2 - ACF Bulletometer

## Details

### Author

- Author: Bubbus (Splambob)
- Github: https://github.com/bubbus
- Steam Profile: https://steamcommunity.com/profiles/76561197970677684
- Youtube: https://www.youtube.com/@Splambob

### Publication Info

- Title: ACF Bulletometer
- Date (dd-mm-yyyy): 24-11-2012
- Source: https://web.archive.org/web/20150304052156/http://www.wiremod.com:80/forum/finished-contraptions/30959-acf-bulletometer.html
- Source Accessed (dd-mm-yyyy): 06-08-2025

## Description

I noticed the trend of projectile trajectory calcuators here, so I decided to join the party and solve a problem that was bugging me in the process. This is a chip that calculates where your ACF guns will hit. It's not completely accurate for slow-moving shells like mortars and grenades, but if you tweak the Correction value it can become accurate enough for any purpose

Be aware, the longer your shells will stay in the air (slow moving shells on a high arc), the more ops this chip will use. Sometimes if you're using a very slow shell and a very high Precision value, the calculation may time out and stop in the air. This is to stop the chip lagging other people - please be considerate to your fellow players

I am sure that other chips exist which are a lot faster and more accurate than this - but I know of no such chips which are publicly available.

This chip also includes a DoHolos mode which uses holograms to draw the trajectory with coloured dots which indicate shell speed relative to initial speed.

Please read the documentation at the top of the script. It'll explain how to set up the chip and how to optimize it for your weapon.

Here are some results from my testing of the chip;

(
    see images
)

The correction value was tuned on the 45 degree grouping. The prediction is never completely accurate for other angles but is usually within the circle of deviation.
