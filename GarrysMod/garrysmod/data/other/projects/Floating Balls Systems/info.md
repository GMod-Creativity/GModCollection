- Author: Paper Clip (glmcd) (glmcdona21) (glmcdona)
- Steam Profile: https://steamcommunity.com/profiles/76561197990877852
- Youtube: https://www.youtube.com/@glmcdona21
<!-- -->
- Title: Floating Ball Protection System & Attack of the Balls
- Date (dd-mm-yyyy): 03-05-2009
- Source: https://web.archive.org/web/20120615073737/http://www.wiremod.com/forum/finished-contraptions/10130-floating-ball-protection-system.html#post96383
- Source: https://www.youtube.com/watch?v=iMMRIhfptvI
- Source Accessed (dd-mm-yyyy): 23-08-2025

---

- GMOD COLLECTION COMMENT:
  1. Spawn the prop: models/Combine_Helicopter/helicopter_bomb01.mdl
  2. Spawn a wiremod prop spawner onto the helicopter_bomb01.mdl
  3. Spawn E2 on top of prop spawner

---

## Floating Ball Protection System & Attack of the Balls

**Description**
This is a contraption which uses E2 apply force and a prop spawner to create your very own personal shield against people shooting you. Whenever any player aims at you with a gun, it intersects the path with one of the balls orbiting you and therefore preventing them from shooting you.

The ball orbit pattern can be changed by crouching and standing back up again.

It is designed to handle up to three people aiming at you at one time.

Balls respawn as they are destroyed.

**Instructions**
Just spawn the attached contraption!

**Video**
Thanks to WhiteFox for helping me with the video!
https://www.youtube.com/watch?v=iMMRIhfptvI

**Expression Code**
I know this could be made simpler, this has probably been very-much overcomplicated, but I think I did a decent job performance wise. Here is a quick summary of what the variables are

**A Entertaining Similar Contraption**
On a side note, here are two really quick entertaining videos of a contraption I made awhile ago similar to this contraption. (And similar to some other contraptions posted, but I assure you I did not copy them!)
https://www.youtube.com/watch?v=oSJDqKUaaCI

And it's simple code

## Re: Floating Ball Protection System

```
Quote Originally Posted by Lyinginbedmon View Post:
From the looks of things, the balls continually check the owner's position against the enemy's weapon shoot position. When it intersects, they move in to intercept.
```

There was consideration of something similar to have my drones protect themselves pre-emptively, but the processing was pretty severe if you assumed an unknown number of enemy targets.
I think I also made a expression that does a similar thing to what you want to do there. This is a chip that I weld to my spaceships/satellites in spacebuild to dodge weapon fire. It only has some of the bullets popular on the server I play on though. If can't handle too many bullets being fired at it at the same time though.

CODE: "Paper Evasion"

```
Quote Originally Posted by TomyLobo View Post
HP:
if (ClosestPlayer:aimEntity() == owner()) { intersect }
```

This is a much simpler way of checking if they intersect you, but the way I do it works a little bit better. It is checking whether it is intersecting a theoretical sphere around you, which helps in that the balls are protecting you before he is able to get his crosshairs over you.

I probably would have done it that simple way, except I had already made the
above spaceship evasion expression which needs to check radius.
