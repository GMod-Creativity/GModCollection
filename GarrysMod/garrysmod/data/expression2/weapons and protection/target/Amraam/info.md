Author: wingman2367
Date: may 2016
Title: Amraam "fun"

*Amraam "fun"*
For this you need propcore to spawn the amraams and all that but otherwise it's just spawning doing /t "name" and then watching the carnage. It's like the admin /explode except for it can accidently kill others, but its all just for fun.
credit to bigdogmat for reworking the code and making much better thank you!


Redone by bigdogmat:
Here, I've redone the code to make it a bit cleaner

And some notes,

Doing the T != noentity() check was fine, though just checking it within an if statement will do as that checks if it's valid.

You didn't need to explode the string. Because you did you could only make the player name one string, unless you need to explode it for other commands then it's not necessary.

Not sure why you made T a persist, nothing in the E2 needed to be persisted.

You didn't need to assign the props to variables, you can call propBreak directly on the function as its an entity method.
