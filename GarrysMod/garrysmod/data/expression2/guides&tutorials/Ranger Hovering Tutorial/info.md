- Author: postman ([TBU-TEC] THE P)
- Steam Profile: https://steamcommunity.com/profiles/76561197997916844
- Youtube: https://www.youtube.com/@blankrofl
<!-- -->
- Title: Re: E2 how do u make something hover ?
- Date (dd-mm-yyyy): 28-07-2011
- Source: https://web.archive.org/web/20150427161915/http://www.wiremod.com/forum/wiremod-general-chat/26889-e2-how-do-u-make-something-hover.html#post240599
- Source Accessed (dd-mm-yyyy): 31-08-2025

## Re: E2 how do u make something hover ?

I presume you're new to wiremod, so this probably wont do you any good, but others looking at this thread in the future may.

First you create a ranger, using "rangerOffset(argument 1, argument 2, argument 3)"
Code:

```
Rng = rangerOffset()
```

The first argument, a number of how long your ranger is, which has to be longer then your hover height.
The second argument of the ranger the prop you want to hover's position.
The third argument is the prop's down direction (Prop:up()*-1) or (-Prop:up())

Giving you:
Code:

```
Rng = rangerOffset(100,Prop:pos(),-Prop:up())
```

You also need to filter the prop that will be hovering from the ranger's view, as the ranger will hit it.
Code:

```
rangerFilter(Prop)
```

Then you need to detect when the ranger hits something, and in that statement you will make the prop go upwards.
Code:

```
if (Rng:hit()) 
{
}
```

The amount of upward thrust is determined by subracting the ranger's distance by the height you want to hover at.
Code:

```
Diff = 40-Rng:distance()
```

then you apply your force in the same statement:
Code:

```
Prop:applyForce((vec(0,0,Diff)*20-Prop:vel())*35)
```

*the apply force code can be changed, this is just what i use*

The final code being:
Code:

```
rangerFilter(Prop)
Rng = rangerOffset(100,Prop:pos(),-Prop:up())

if (Rng:hit()) 
{
      Diff = 40-Rng:distance()
      Prop:applyForce((vec(0,0,Diff)*20-Prop:vel())*35)
}
```

Hope that helps SOMEONE, at least :D
