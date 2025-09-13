# Expression 2 - [E2] Jet

## Details

### Author

- Author: Spoom (SpoomWolf) (Spoon God)
- Steam Profile: https://steamcommunity.com/profiles/76561197997700900
- YouTube: https://www.youtube.com/@IRASpoon

### Publication Info

- Title: [E2] Jet
- Date (dd-mm-yyyy): 14-08-2010
- Source: https://web.archive.org/web/20150503192332/http://www.wiremod.com:80/forum/finished-contraptions/22009-e2-jet.html
- Source: https://www.youtube.com/watch?v=qggi_TM8GUg
- Source Accessed (dd-mm-yyyy): 04-09-2025

## Description

This E2 turns any prop into a jet. Recommend you use an actual jet model; note that PHX3 has some jets (one jet in different sizes) but this also works well on military models [1 and 2] planes.

[YouTube - E2 Jet by Spoon_God](https://www.youtube.com/watch?v=qggi_TM8GUg)

As the video says it is easy to setup, All it requires is:

- The Jet Model (to prevent tickQuota rape it only uses one prop, so I recommend you only use one prop.)
- A Seat (This was designed to work with the pod, so I recommend you use that.)
- An Adv. Pod Controller, linked to the seat.
- The E2 itself.

### Setup

```plaintext
1. Place the pod inside the jet prop respectively.
2. Spawn the E2 ON THE JET PROP, if you do not have an advanced pod controller it will remove itself and swap you to the adv pod tool, (if wire_expression2_concmd is 1)
3. Place an advanced pod controller ON THE JET PROP (you can link it now if you wish.)
4. Place the E2 ON THE JET PROP.
5. Wirelink the E2 to the advanced pod controller (if wire_expression2_concmd is 1, it will swap to the wire tool to do this)
6. If not already done, link the advanced pod controller to the vehicle, (if wire_expression2_concmd is 1, it will swap to the adv pod tool for you)
7. Enter the pod, you're good to go!
```

### Controls

```plaintext
W - Pitch down
S - Pitch up
A - Roll left
D - Roll right
Shift (+Speed) - Increase throttle
Alt (+Walk) - Decrease throttle
Space (+Jump) - Brake (Turn faster, also decreases throttle)
```

### HUD

You will see 2 bars when you enter the pod:

- The Top Bar `|-(-)--+---------------|` This is your speed, once you fall below the `+` you will stall.
- The Bottom Bar `|---(-)----------------|` This is your versatility according to the current speed, (you can turn faster when this is at 100%, which is 60% speed)

**Note:** If you stall, you will begin to drop **like a rock**
To recover from a stall, you need to level out your plane and increase throttle until it passes the `+` again.
You can use WASD when stalled.

For those of you familiar with my combat system, yes, I am working on making this shoot homing holo-missiles.
