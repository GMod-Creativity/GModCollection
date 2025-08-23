- Author: Technicolour (Techni)
- Steam Profile: https://steamcommunity.com/profiles/76561197983168201
- Youtube: https://www.youtube.com/@Technicolour777
<!-- -->
- Title: Fully 3D mouse controlled Flight
- Date (dd-mm-yyyy): https://web.archive.org/web/20121114023129/http://www.wiremod.com/forum/finished-contraptions/14446-fully-3d-mouse-controlled-flight.html
- Source: 20-09-2009
- Source Accessed (dd-mm-yyyy): 23-08-2025

## Fully 3D mouse controlled Flight

As many people probably know the controling of flight is somewhat difficult, there's the typical pitch/roll/yaw method in which the vehicle will orientate itself based on the gyroscope, however this system is greatly limited: Firstly there's the pitch zero point this is that you can't look beyond directly up, rather, you have to 'yaw' around it, and likewise for down. Secondly is gimble lock. When you're looking up yaw also rolls, and visa versa. And lastly is that it's not truely 3D. You look as far down as you can then yaw left 90 degrees, if it was truely 3D you'd be looking directly left with a 90 degree roll, however you're not, you're just looking straight forward. Halo is a good example of this limited flight system.

Another method of flight control is simply resisting/dampening movements, this offers true 3D flight and doesn't suffer from gimble lock or the zero point problem however you cannot orientate to a specific angle, making mouse-look control impossible.

Using vectors instead of pitch roll and yaw usualy gets rid of the pitch zero point however there is still the problem of gimble lock and that it's not truely 3D. I used vectors on my tie-fighter a few months ago: YouTube - techni117's Channel
Mouselook makes it easy to control and easy to aim, however What if I want to combine a truely 3D system with the ease of use and inherent accuracy of mouse controlled flight? I have to delve into quaternions.

This is my latest creation:

Quaternion 3D Flight - Xfire Video

it uses quaternions for both the cam controller and for the control and orientation of the craft itself. The vehicle will orientate itself directly (The shortest rotation route) to wherever the camera is orientated. The camera is controlled using an eyepod for the Yaw and Pitch, and Shift and R for the roll. It can do everything a true 3D craft can do: Barrel roll, leep and turn in any dimension at angle, completely independently of where 'up' and 'down' are in the world. It doesn't suffer from any of the problems that semi-2D flight does. If you look down 45 dgerees, yaw 180, you wont still be lookign down 45 degrees (ala pitch/roll/yaw craft), rather, be looking up 45 degrees. Likewise if you yaw 90 instead, you'll be rolled 45 degrees.

I'm currently tidying up the code and making something decently pretty to look at before I post an advance dupe/E2-Code. My first improvements will be to the forwards flight system, which is right now just a regular thruster on the rear.

Massive thanks to Fizyk, without his continuing efforts on Quaternion E2 code this would've been incredibly difficult, if not impossible.

## Re: Fully 3D mouse controlled Flight

CODE

I think everything should be explained in the comments, but feel free to ask any questions.

Note: If it spazes out delete the *E:inertia() from the last line, I don't know why this causes it to spaz sometimes but it does, it didn't on my original but it has on all my subsequent ones.
