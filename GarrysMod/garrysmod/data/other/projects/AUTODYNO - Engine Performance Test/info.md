- Author: Tolyzor
- Steam Profile: https://steamcommunity.com/profiles/76561197980070446
- YouTube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor
<!-- -->
- Title: AUTODYNO - Engine Performance Test
- Source: https://web.archive.org/web/20150426144535/http://www.wiremod.com/forum/finished-contraptions/24735-autodyno-engine-performance-test.html
- Source: https://www.youtube.com/watch?v=b1JRxzCrFwA

**autodyno_r1**
- Source: https://gmods.org/view/43023

**autodyno_r1.1**
- Source: https://gmods.org/view/33541

## AUTODYNO - Engine Performance Test
This is a dynamometer that will test any engine to find it's performance.
  
It can be used to;
  
Help make engines: Determine what increases performance and what doesn't
Compare engines: See who's engine has the best performance
Help make transmissions/powertrains: See what is efficient and what isn't
...And obviously, make vehicles.
  
  
Requires no calibrating by the user. The screen is a simple to use touch screen, and you can change the units between imperial, S.I or Gmod units.
  
HDR users: press the middle of the screen to darken it.
  
Code:
Unit conversion
  
Torque
gfu.glu = applyTorque() * tick rate
n.m = gfu.glu * toUnit("m", 1)^2
ft.lbf = n.m * 0.737562149
  
Power
gpu = gfu.glu * rad/s
watts = gpu * toUnit("m", 1)^2
hp = watts * 0.00134102209
Technical features
-Load applied by a gain scheduling PID controller
-Detects rotor spazz and reacts to prevent it
-Will not record a data point unless all contributing factors are within a pre-set range
-Rotor momentum and drag modelled and compensated for
-Errors reported both real-time and printed to console
