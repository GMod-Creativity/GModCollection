- Author: postman ([TBU-TEC] THE P)
- Steam Profile: https://steamcommunity.com/profiles/76561197997916844
- Youtube: https://www.youtube.com/@blankrofl
<!-- -->
- Title: [E2] Three of my best E2's release thread [STARGATE, HOLO DASHBOARD, POLTERGIEST]
- Date (dd-mm-yyyy): 07-11-2011
- Source: https://web.archive.org/web/20150330233825/http://www.wiremod.com:80/forum/finished-contraptions/27849-e2-three-my-best-e2s-release-thread-stargate-holo-dashboard-poltergiest.html
- Source Accessed (dd-mm-yyyy): 30-08-2025

## [E2] Three of my best E2's release thread [STARGATE, HOLO DASHBOARD, POLTERGIEST]

Now i decided to release a bunch more e2's today, I just finished the "AI release thread (check sig), and now i have 3 more e2's

Really these e2's deserve their own threads, but i didnt think posting 4 separate threads would be a great idea.

Im going to split this into 3 sections, each E2 will have instructions, description, code, and pictures.

__________________________________________________ __________________________________________________
_________________________________________Hologram Dashboard___________________

**Description:** this is a dashboard, made out of holograms, it is designed to take data inputs, and display them in the form of a dash. It is not meant to control the vehicle in any way. I made this specifically using my crawler, of which the e2 engine has gears, 8 of them (-2,-1,0,1,2,3,4,5).

Making this was a blast, and also quite difficult, over the period of about 2 weeks. It has a gear shift, a working gas, brake, and clutch pedal, a speedometer percent bar, a working steering wheel, the ability to be right OR wrong(left) side driven. A rear view mirror, and last but not least, a beer.

**Instructions:** Wire the WL:wirelink output to your pod controller, and reweld your seat (or place it) in the correct position.
Wire the SteeringPlate:entity output to your steering plate/steering bar, the dash will pull angles from this and display it by turning the wheel (it has a bug while going reverse and steering, not enough of a problem to fix)
Next IF you have an engine that has gears, OR some way to define the gears, wire the "GEAR" output to that.
IF you do NOT have a way to get the gears, the e2 will base the gears on your speed, the system does not work great, but it does still work correctly.
Finally, drive your car around :p

**Pictures:**
*mind the lower resolution, i made it lower so i could still use the task bar*

__________________________________________________ __________________________________________________
__________________________________Postman's Poltergeist_________________________

**Description:**
This is by far one of my favourite, and funnest E2's
It is exactly what the title says, its a poltergeist you can control and move around. (for those of you that dont know, a poltergeist is an object controlled by a ghost or spirit)

**Instructions:**
Spawn the E2, and move the lamp.
Spawn a chair, wire the WL:wirelink on the e2, to the adv pod.
Get in and read the instructions that come up as hints.

W A S D: movement
Right click: Steadies the prop(doesnt work well on the lamp)
Left click: Cloak prop for a few seconds, or if it is an explosive, explode.
F:Ghost or teleport. The prop will freeze, turn into a holo, move the holo and press F again, prop will teleport, Left click cancels.
Alt:changes model to nearest prop.

R: respawn prop with same model.
(When Prop has exploded or broken) R: respawn same prop
(When Prop has exploded or broken) R + Shift: Respawn lamp model.

This e2 is a blast, fun to mess with people, try it out, you wont be disappointed.

**Pictures:**

__________________________________________________ __________________________________________________
__________________________________Holo Stargate_______________________________

**Description:**
As you can imagine, this one was really hard to make, and still has quite a few glitches, but it is REALLY fancy.
(if you dont know what stargate is, gtfo the internet.)
This wouldnt be at all possible if it weren't for this guy:
[[ E2 ] Hologram Clipping Gates](https://web.archive.org/web/20150330233825/http://www.wiremod.com/forum/finished-contraptions/25744-e2-hologram-clipping-gates.html)
He gate me his bit of code to make things clip like such, and i overhauled it, and made it into a stargate. (it was 10^20 X harder than that though >_>)

**Instructions:**
Due to the fact that i did not know about "wire_holograms_burst amount X", the second gate takes 10 seconds to set up, but its not that bad.

The first gate will be made where the e2 is, facing you, the second spawns when you hit E.

Place items in the first OR second gate (i know in stargate its different), and they will come out the other, depending on which direction its facing (you can tell by which way the water shoots out)

Get really close to the REAL object, and right click, it will physically teleport to the other portal, yes this works with seats (but be careful)

You can use multiple objects going either way, but beware of ops, its quite a laggy thing.

Also, the gates glow in the dark, pics below.

THIS CODE IS VERY MESSY, AND CRAPPY, BUT IT GETS THE JOB DONE!

**Pictures:**
LOTS of pictures.

---

***Thus concludes***

Enjoy these chips, i sure did, and it was quite fun putting them together, dont put them elsewhere.

EDIT: 12/21/11
Fixed:I derped on the poltergiest, Using W+shift in ghost went backwards
Added: The mass is now rememberd between spawns, and when picking a new prop, the mass is set to a minimum of 10, this should fix any control issues with props weighing 1
