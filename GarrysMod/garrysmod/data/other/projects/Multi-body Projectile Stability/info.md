- Author: Tolyzor
- Steam Profile: https://steamcommunity.com/profiles/76561197980070446
- YouTube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor
<!-- -->
- Title: Multi-body Projectile Stability
- Source: https://web.archive.org/web/20150304055403/http://www.wiremod.com/forum/finished-contraptions/31517-multi-body-projectile-stability.html#post272293
- Source: https://www.youtube.com/watch?v=7RpkkDqbpfU

## Multi-body Projectile Stability

Instructions: update code to this, adv wire E1 to the red block, E2 to the grey block. Press kp 1 to make the projectile hover, press kp 4 to arm data logging, press kp enter to view cam (kp 2 cycles views). Press kp 0 to launch. Before the projectile hits the ground, press kp 4 to stop data logging. Press kp del to plot data. Press kp 1 to return projectile to launcher hover.

## Re: Multi-body Projectile Stability (launcher)

It's a little hacky, as it's simple and I didn't expect anyone would want to see it!
I added the dupe to the OP too, so anyone can have a play.

Quote Originally Posted by shadowsnipe View Post
Nice im interested in learning how you made it curve like that when it shot out
Once it is launched, inertia, gravity and drag are the only forces on the projectile, I did nothing but get the quantities right!

It works just like real life stabilised projectiles work.
For the fin-stabilised projectile, it is stabilised like a badminton shuttlecock; the centre of mass is in front of the centre of drag.
For the spin-stabilised projectile, it is stabilised like a spinning top; the angular momentum resists the overturning moment caused by the high drag nose and the direction of airflow always coming from beneath it. However, unlike a spinning top which resists a gravity overturning moment, the direction of the overturning moment changes direction with the trajectory. This is why the spin-stabilised projectile can be over-stabilised - the projectile cannot turn towards that direction fast enough. The optimum spin is a balance between getting there fastest, but still preventing overall tumbling by reducing the yaw angle.
