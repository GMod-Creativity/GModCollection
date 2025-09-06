- Author: Spoom (SpoomWolf) (Spoon God)
- Steam Profile: https://steamcommunity.com/profiles/76561197997700900
- Youtube: https://www.youtube.com/@IRASpoon
<!-- -->
- Title: [E2] Jet
- Date (dd-mm-yyyy): 14-08-2010
- Source: https://web.archive.org/web/20150503192332/http://www.wiremod.com:80/forum/finished-contraptions/22009-e2-jet.html
- Source: https://www.youtube.com/watch?v=qggi_TM8GUg
- Source Accessed (dd-mm-yyyy): 04-09-2025

## [E2] Jet

This E2 turns any prop into a jet. Recommend you use an actual jet model; note that PHX3 has some jets (one jet in different sizes) but this also works well on military models [1 and 2] planes.

https://www.youtube.com/watch?v=qggi_TM8GUg

As the video says it is easy to setup, All it requires is:

- The Jet Model (to prevent tickQuota rape it only uses one prop, so I recommend you only use one prop.)
- A Seat (This was designed to work with the pod, so I recommend you use that.)
- An Adv. Pod Controller, linked to the seat.
- The E2 itself.

_Setup_

- Place the pod inside the jet prop respectively.
- Spawn the E2 ON THE JET PROP, if you do not have an advanced pod controller it will remove itself and swap you to the adv pod tool, (if wire_expression2_concmd is 1)
- Place an advanced pod controller ON THE JET PROP (you can link it now if you wish.)
- Place the E2 ON THE JET PROP.
- Wirelink the E2 to the advanced pod controller (if wire_expression2_concmd is 1, it will swap to the wire tool to do this)
- If not already done, link the advanced pod controller to the vehicle, (if wire_expression2_concmd is 1, it will swap to the adv pod tool for you)
- Enter the pod, you're good to go!

_Controls_

- W - Pitch down
- S - Pitch up
- A - Roll left
- D - Roll right
- Shift (+Speed) - Increase throttle
- Alt (+Walk) - Decrease throttle
- Space (+Jump) - Brake (Turn faster, also decreases throttle)

_HUD_
You will see 2 bars when you enter the pod:

- The Top Bar |-(-)--+---------------| This is your speed, once you fall below the + you will stall.
- The Bottom Bar |---(-)----------------| This is your versatility according to the current speed, (you can turn faster when this is at 100%, which is 60% speed)

Note: If you stall, you will begin to drop **like a rock**
To recover from a stall, you need to level out your plane and increase throttle until it passes the + again.
You can use WASD when stalled.

For those of you familiar with my combat system, yes, I am working on making this shoot homing holo-missiles.
