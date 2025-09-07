# Expression 2 - UltiMultiDoor

## Details

### Author

- Author: Rekondo
- Steam Profile: https://steamcommunity.com/profiles/76561197993421468

### Publication Info

- Title: [E2] Small E2 collection!
- Date (dd-mm-yyyy): 31-07-2014
- Source: https://web.archive.org/web/20150508092541/http://www.wiremod.com/forum/finished-contraptions/33376-e2-small-e2-collection.html
- Source Accessed (dd-mm-yyyy): 22-08-2025

## Description

(Part of pack)

Here is a small collection of E2s I've been working on.
None of these are very complicated, but I use them all the time.

### UltiMultiDoor

Last one!

The UltiMultiDoor! (Pls, I'm terrible at names)
Shoot it in the corner of of a doorway and wham, instant automatic door! Or maybe you already have a prop there, shoot the E2 on it and wham, instant automatic door! Or if you like keeping chips in a separate spot, wire it to an entity marker and wham, instant automatic door!  
There are variables for model, material, range, speed and one called "All" that you can enable to let anyone use the door (It default to opening for just you) There is also an array you can add players to for allowing them to use it as well, but there is currently no built-in way to add people (Sorry). Also, look at it and type ".lock" to lock it, so it stays down!

By the way, you have to change the model variable to something that fits your doorway! It also has inputs for Keypads and/or buttons!

### Final Note

That's all for now. I'll make more posts with random E2s like these when I get around to re-building my library of chips that disappeared after I re-installed gmod and forgot to back up all my sweet, sweet e2s and advdupes... T_T

Oh well, cya!  
~Rekondo

---

### ICEMAN[CGA] question
**ICEMAN[CGA]:**  
i love the door e2 but how to i make it go left/right?

**Rekondo's answer:**  
If your door is square, you can just go to the bottom of the code and change the

```
E:setPos(BasePos+vec(0,0,Anim))
```

to

```
E:setPos(BasePos+vec(Anim,0,0)
```

or

```
E:setPos(BasePos+vec(0,Anim,0))
```

depending on what way the door is facing.

If you want it to go down or to the other side just put a - in front of the Anim part  
If the door is not a perfect square, you have to tweak the

```
    Top=E:nearestPoint(E:pos()+vec(0,0,1000))
    Bot=E:nearestPoint(E:pos()-vec(0,0,1000))
    L=Bot:distance(Top)
```

to fit the direction you wanna go. (X or Y axis)
