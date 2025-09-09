# Expression 2 - [E2] GmodPaint!

## Details

### Author

- Author: Donkie
- Steam Profile: https://steamcommunity.com/profiles/76561197993138946

### Publication Info

- Title: [E2] GmodPaint!
- Date (dd-mm-yyyy): 15-03-2011
- Source: https://web.archive.org/web/20110812045304/http://www.wiremod.com:80/forum/finished-contraptions/25211-e2-gmodpaint.html
- Source Accessed (dd-mm-yyyy): 07-09-2025

## Description

Fantastic everyone, Donkie has done it again! (even though I've never released something before)  
I just made MSPaint, in garrysmod! (With a little loss of features).  
Alright, it's using a Digitalscreen for drawing, EGP for toolbox, Consolescreen for infolog, and a normal 2 numberscreen for some additional unneeded info.

### The feature's it got is:

```
- Fully working Saving&Loading with sort-of-compression (thanks Jasongamer & Andre)
- Fully working bucket tool
- Complete color choice
- Tools: Pencil, Bucket, Eraser, Spraycan and Pickcolor
- Ability to set pencil size from 1 to 10 pixels
- Set custom owner
```

<!-- Some pictures: (Don't mind my immatureness)
freespace_revolution0005.jpgfreespace_revolution0006.jpgfreespace_revolution0007.jpgfreespace_revolution0009.jpg
The lightblue thing is me filling the black space with lightblue color. It's filling pattern is quite weird, don't mind it, it's doing its job. -->

### Chatcommands:

```
!owner <partofplayername> - Sets who can draw on the screen and use the chatcommands (except !owner)
!rgb <red> <green> <blue> - Set a custom color
!file <filename> - Set which name the file you save to will have.
!load <filename> - Load a picture
```

### To use saving/loading:

```
1. Paint your picture
2. Define imagename using !file \<name>, e.g, !file testpicture, several words must be in quotes
3. Press the Save button on the screen
4. Wait untill the progress says 100 and you've gotten a hint about that it's saved.
5. Save done!
6. Loading: write !load \<filename>, e.g, !load testpicture, to load the picture. Wait until
   progress gets to 100% and log says that it's done.
7. Saving goes twice the speed of loading, couse it saves at 2 points at same time. Loading prints
   in 66.7 cells/second, and saving saves in 133.4 cells/second.
```

My saving compression I got is, `<EndChunkCell>-<ChunkColorInBase32>#`  
Meaning, painting cell 0 to 400 color red, and chunk 401 to 600 green, it would be "400-7J5VE0#600-7P0O#". I'm quite proud of it, and it works great.

I have only tested this at digitalscreen PCB size 7, EGP screen at size 5, and at pixel scales 64x64 and 128x128. To change pixel scale, change the topmost value in if(first()){, ScreenSize, to what you want.

### Saved samples:

- Fancyguy
- Penis
- House with tree

<!-- Mainscreen:
gmodpaint v3.txt

Router:
gmodpaint router v2.txt

I would recommend spawning both of these frozen, as the datasockets won't be happy otherwise. -->

---

### Re: [E2] GmodPaint!

Update everyone!

I decided to pick up this project again. And I did it fantastically! I managed to add dataports and sockets to the screens, and a router/switch thingie. You connect the "E2" port from the screen to the bottom layer of sockets on the router, and the "Screen" port from the screen, to the top layer of sockets. Then you can connect several screens same way, and you got a collaborative drawing pad thingie! Every feature works just the same, however, the E2 might need a refresh if the colors muck up for some.  
New command, !ownerscr <player> while you're looking at a screen makes only THAT screen get it's owner set. normal !owner sets it for all screens.
