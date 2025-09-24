# Project - AUTODYNO - Engine Performance Test

## Details

### Author

- Author: Tolyzor
- Steam Profile: https://steamcommunity.com/profiles/76561197980070446
- YouTube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor

### Publication Info

- Title: AUTODYNO - Engine Performance Test
- Date (dd-mm-yyyy): 06-02-2011
- Source: https://web.archive.org/web/20150426144535/http://www.wiremod.com/forum/finished-contraptions/24735-autodyno-engine-performance-test.html
- Source: https://www.youtube.com/watch?v=b1JRxzCrFwA
- Source: https://gmods.org/view/33541
- Source Accessed (dd-mm-yyyy): 19-09-2025

## Description

This is a dynamometer that will test any engine to find it's performance.

It can be used to;

Help make engines: Determine what increases performance and what doesn't
Compare engines: See who's engine has the best performance
Help make transmissions/powertrains: See what is efficient and what isn't
...And obviously, make vehicles.

Requires no calibrating by the user. The screen is a simple to use touch screen, and you can change the units between imperial, S.I or Gmod units.

HDR users: press the middle of the screen to darken it.

### Code

```plaintext
Unit conversion

Torque
gfu.glu = applyTorque() * tick rate
n.m = gfu.glu * toUnit("m", 1)^2
ft.lbf = n.m * 0.737562149

Power
gpu = gfu.glu * rad/s
watts = gpu * toUnit("m", 1)^2
hp = watts * 0.00134102209
```

### Technical features

- Load applied by a gain scheduling PID controller
- Detects rotor spazz and reacts to prevent it
- Will not record a data point unless all contributing factors are within a pre-set range
- Rotor momentum and drag modelled and compensated for
- Errors reported both real-time and printed to console

### Video

See the video for a demonstration:

[YouTube - Autodyno - Engine Performance Test](https://www.youtube.com/watch?v=b1JRxzCrFwA)

<!-- Download latest version:
autodyno engine performance test r1-2.txt
AUTODYNO Version 1.2

Old versions:
AUTODYNO Version 1.1
AUTODYNO Version 1.0 -->

### End

If you are having testing issues accompanied by error hints, please post the error message dump printed to console upon test completion/termination and I will do my best to solve the problem.

Thanks to the inhabitants of Spaceindavers, Nodex and Unsmarts for providing engines to test!
Sneaky peek.

![image1](AUTODYNO%20R1.1/AUTODYNO%20r1.1%20boxer%204%20cylinder%20(from%20video).jpg)
