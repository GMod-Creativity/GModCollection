# Expression 2 - Re: Comprehensive Gmod physics guide

## Details

### Author

- Author: Tolyzor
- YouTube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor

### Publication Info

- Title: Re: Comprehensive Gmod physics guide
- Date (dd-mm-yyyy): 04-02-2010
- Source: https://web.archive.org/web/20150317231955/https://wiremod.com/forum/wiremod-general-chat/17874-comprehensive-gmod-physics-guide-3.html#post233039
- Source Accessed (dd-mm-yyyy): 11-08-2025

## Description

**Tolyzor:**
I always used to think it was 66 or 67 yeah, but then i only tested it by counting average ticks in a second. I realised I had got it wrong when f=mg didn't quite work using 66 or 67.

**It is derived in the following way;**

Gravity is known to be an acceleration of `600 [inches/s^2]` in the `-Z` direction.

`applyForce` is in units of `[Kg * inches/tick^2]`

using

$$F = m g$$

Force due to gravity is in units of `[Kg * inches/s^2]`

It is then apparent that `applyForce = x * Force`, where `x = ticks` in a second.

`X` can be found experimentaly;

Aim to achieve 0 acceleration due to gravity by using `applyForce` in the opposite direction, when `mass = 1`:

$$\text{sum of forces} = \frac{\text{applyForce}(\vec{0,0,1})}{x} + (-600) = 0$$

therefore to negate force due to gravity in game

```
Entity:applyForce(vec(0, 0, 1)/x)
```

using in-game experimentation, x is found to be exactly 66.566669
note; try releasing the prop you are testing using the grav gun rather than the physgun to get more accurate results, the physgun makes a props mass increase.

tldr proof:

```
@name Gravity negater
@inputs Target:entity
@trigger none
runOnTick(1)
Target:applyForce(vec(0, 0, Target:mass()) * gravity() / 66.566669)
```

### Re: Comprehensive Gmod physics guide

**Josef:**  
For force calculations, using a tick rate of 66.566669 makes the applyForce physics work perfectly, but the ticks are really 15ms each, for a rate of 66.666 repeating. It seems there's a slight error in either the physics engine or the applyForce code.

Also, the tick rate is changeable by adding -tickrate # to the launch shortcut.

**Tolyzor:**  
Ahh, interesting to know.

**Azrael:**  
Also, when doing any testing of things like this, air_density 0 in the console should be used to cancel the effects of air resistance.

**Tolyzor:**  
Unless you are trying to determine drag of course

But yeah I did that.
