# Expression 2 - [E2-holo] Holo Combat System (HCS) and a little holo tank using it

## Details

### Author

- Author: feha
- Steam Profile: https://steamcommunity.com/profiles/76561197972236094

### Publication Info

- Title: [E2-holo] Holo Combat System (HCS) and a little holo tank using it.
- Date (dd-mm-yyyy): 05-02-2010
- Source: https://web.archive.org/web/20110423051338/http://www.wiremod.com/forum/finished-contraptions/17905-e2-holo-holo-combat-system-hcs-little-holo-tank-using.html
- Source Accessed (dd-mm-yyyy): 28-09-2025

## Description

Ok, I have spent like exactly 1 weak for doing this (:O) and I know they are not perfect or anything, but here I present to all you holo-lovers out there...

### The Holo Combat System! (HCS for short)

Basicly, it is 2 different codes cooperating via globals. There is 3 "modes" for firing, and then there is the target code, checking if it got hit, and if so, apply dmg and return hitpos (if attacker want to create a fx). Everything uses 1 globals and then sets a hit-global for hitpos, but this is not surely a good thing, as if there is to many things firing (or a weapon with to high rof), they will start override eachothers.  
Make sure that the variables is not conflicting with anything/eachothers when adding HCS.  
HCS is also made to work without regards to pp, if you dont like that, just remove `gShare(1)`  
I made sure to make it only use stuff in the regular wire svn (except the tank e2, it uses e2 hud aswell).

<!-- There is a bit of story of why I made this system, it all started here and then went on to here, ending here (as in this thread). -->

### Credits

Wiremod team, especially the ones creating e2.  
Everyone who showed enough enthusiasm to make me finish this, and those who showed enough to make me upgrade it.  
Everyone and anyone who tested my beta (even if they didnt know they were testing a beta) and gave feedback.  
Anyone I forgot.

### Special thanks to

Rynox and his little turtle for always being at server to give me feedback.  
Myself, for not buying ME2 immediately and getting stuck in it instead.

### HCS - Shooter

This is the attacking code, made so a owner can just walk around using his mouse and use keys to fire. The ID is to make an individual global that returns hitpos. The flag is if it shall hit every target on a row, or only one (if false, it only hit the target with the youngest e2).

see [hcs-shooter.txt](./hcs-shooter.txt)

### HCS - Dummy

It is kind of easy to copypasta to bottom of e2, just make code for what shall happen on death and make sure variables dont collide with your variables.

see [hcs-dummy.txt](./hcs-dummy.txt)

### The holo tank example!

I know many people would get quite confused if I didnt post an example, so here it is. I made this for debugging, improving and whatnot to the HCS, aswell as to let you get a fun holo game, that you also can read to see how to sucesfully implement HCS.
Now, I know this is half-assed in some aspects, such as I skipped adding a ranger forward to make you not go into walls, but this e2 is mostly made for the joy of playing, and I must say going trough walls in a interesting tactic.

#### Ctrls

```plaintext
W/S - Forward/Backward.
A/D - Turn left/right.
Shift - Go faster.
Alt - Go slower.
Space - Hold to get turret view, and have ability to aim on the z axis aswell.

F - Toggles the turret follow tank or not (as in, if you turn, you still aim same dir, but if you press f then turn 90 degrees, your aim does to).
Mouse - Aim turret (not in height, interesting for game mechanics, and not as annoying when aiming)
LMB - Shoots a laser, dmg = 1 and rof = 10, so quite weak.
RMB - Shoots an explosive bullet in an arc, uses V = V0+a*t (just like tanks gravity).
```

#### The tank

Here is the code for the tank, it is simple to wire, just make a pod, an adv pod ctrl (linked to pod) and wire the wirelink, cam ctrlr (linked to pod) and wire activate to pod ctrlrs active, position to e2s view and angle to e2s angle.
If you want another color then white, there is a variable in the `first()`.
It can also pass gaps that is less then 10 units wide. as I also made the rangers responsible for angling tank right work for checking if it hit ground (10 units between them).

see [holo-tank.txt](./holo-tank.txt)

### Media

No, I wont record it, I would appreciate if someone else could do that for me tho.

### Other

Now! Enjoy and make some holo combat games. I noticed helicopters were a very popular suggestion during testing, and I will actually add one soon.  
I would love some feedback, questions, and suggestions!

If you had not figured it out yet though, this post is about the HCS, with a tank game as an example, so dont expect that I will put any more work into the tank game (yes I might, but it is nothing to be expected), as it is just a example :P.

If you know a better way to do anything, please tell me!

### tl;dr

I made a holo comabt system (HCS) that work with globals. Very easy to implement, and very usefull in holo games.  
I also made a example game with holo-tanks using HCS.

### Update!

Ok, I updated hcs to use signals (dmg is dealt in same tick), return real hitpos (before it was nearest point), use line-plane intersection, have a flag for if it should hit all in a row and such.

In other words, it is improved.

I also added a little to the tank.

**Last edited by feha; 02-05-2010 at 02:15 PM. Reason: UPDATE!**
