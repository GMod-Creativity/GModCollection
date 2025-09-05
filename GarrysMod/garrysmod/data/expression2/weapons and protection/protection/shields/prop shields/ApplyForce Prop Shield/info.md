- Author: xTarifx
- Steam Profile: https://steamcommunity.com/profiles/76561198004019259
<!-- -->
- Title: ApplyForce Prop Shield
- Date (dd-mm-yyyy): 11-01-2010
- Source: https://web.archive.org/web/20100714102305/http://www.wiremod.com:80/forum/finished-contraptions/17274-applyforce-prop-shield.html
- Source Accessed (dd-mm-yyyy): 26-08-2025

## ApplyForce Prop Shield

Hey again,

Gonna release this lil thingy I made to try and get feedback on it and see what I can improve. No pictures by the way, its just a model.

**Commands:**
    - protect (RADIUS) - Creates a invisible sphere around the owner and if a prop or a vehicle enters this radius, it moves quickly and attempts to knock it away or pin it to the ground.
    - protect sphere - Same thing but it is a set radius of 320 with a bubble to show where you can enter with props or vechiles.
    - protect off - Simple as.

The colour of the entity represents if it is in safe mode, standby, or if it is attacking a prop. (Green, yellow, red)

Anyway, here is the code. Thanks to Flieboy(Fliecheese) for telling me how I could include a vehicle into a findIncludeClass.

It works quite well and moves quickly. The only time that it would have a issue is if someone spawned a prop on you. It only targets 1 prop in the radius until it is moved out, but it goes for the closest one first.

Give me back some comments or changes I could make.
