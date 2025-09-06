- Author: blaknite
- Steam Profile: https://steamcommunity.com/profiles/76561197969308510
- Github: https://github.com/blaknite
<!-- -->
- Title: The LANBox ACF Tank Controls
- Date (dd-mm-yyyy): 04-06-2012
- Source: https://web.archive.org/web/20141017155126/http://www.thelanbox.com.au/blog/post/393/garry-s-mod-acf-tank-controls/
- Source: https://web.archive.org/web/20140228234021/http://www.thelanbox.com.au/uploads/lb_acf_tank_controls.txt
- Source: https://web.archive.org/web/20150506130949/http://www.wiremod.com:80/forum/finished-contraptions/33601-acf-car-controls-lanbox-mod-v1.html
- Source Accessed (dd-mm-yyyy): 10-08-2025

## The LANBox ACF Tank Controls

large_393.jpg

One of the things we love most here at The LANBox is building tanks in GMod using Armored Combat Framework. Most of all we try to make them as realistic and easy to drive as possible. That's where this expression comes in. This plug and play chip will give you excellent and realistic control over your ACF tanks. Instructions and download after the break.

First things first. This isn't a tut on building a tank in GMod, if you'd like some tips feel free to join us on The VehicleBox and nicely poke one of the admins/regulars for a few tips.

With that done it's on to the juicy bits. The LANBox ACF Tank Controls expression is designed to work with either a dual-gearbox or dual-clutch gearbox configuration. If you want your tank to pivot you'll need to use a dual-gearbox configuration. If however you only require turning (like WW2 era tanks) then you can disable pivoting by setting the PivotSpeed variable to -1. Below is an example of a dual-gearbox configuration.

d6c70d_gm_carconstruct_b1-80001.jpg

If you have pivoting enabled you'll also need a speedometer placed at the location of your Z axis which is used to determine whether or not it is safe to pivot. Those not using pivot can ignore this input.

The rest is pretty self explanatory, wire all the left outputs to your left gearbox and the right outputs to your right gearbox. Wire up your engines to the RPM1 and RPM2 inputs and the Throttle output. If you are using a dual-clutch gearbox you can use a single engine and wire it up to RPM1.

The expression has a few configuration variables that are explained in the code. Be sure to check them and change them to match your engine(s) and tank. The download link is below. Let us know if you like it in the comments and please refrain from uploading it elsewhere. Thanks and enjoy!

https://web.archive.org/web/20141017155126/http://www.thelanbox.com.au/uploads/lb_acf_tank_controls.txt
