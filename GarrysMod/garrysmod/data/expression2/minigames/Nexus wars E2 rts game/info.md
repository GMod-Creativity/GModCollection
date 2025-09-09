# Expression 2 - Nexus Wars: two-player rts propcore game

## Details

### Author

- Author: Paper Clip (glmcd) (glmcdona21) (glmcdona)
- Steam Profile: https://steamcommunity.com/profiles/76561197990877852
- Youtube: https://www.youtube.com/@glmcdona21

### Publication Info

- Title: Nexus Wars: two-player rts propcore game
- Date (dd-mm-yyyy): 28-04-2011
- Source: https://web.archive.org/web/20160519203211/https://wiremod.com/forum/finished-contraptions/25742-nexus-wars-two-player-rts-propcore-game.html
- Source: https://pastebin.com/fLAPkH6A
- Source: https://www.youtube.com/watch?v=e29cnWGgWz4
- Source Accessed (dd-mm-yyyy): 25-08-2025

## Description

If you create your own unit tree or ai strategy, please post it!

### VIDEO

https://www.youtube.com/watch?v=e29cnWGgWz4

### CODE

**Click on this link for the e2 code:** [[C] Garry's Mod Nexus Wars e2 - Pastebin.com](https://pastebin.com/fLAPkH6A)  
A whopping 2000 lines of code, I seem unable to include it in this post because it is so big. The attached files at the bottom of this post are dupes where the e2 chip is already wired up.

#### Input wiring instructions:

- Egp1:wirelink -> EGP Screen for player 1
- Egp2:wirelink -> EGP Screen for player 2
- Base1Link:wirelink -> Main base prop for player 1
- Base2Link:wirelink -> Main base prop for player 2
- Reset -> From a non-toggle wire button. Hold this button to reset the system.
- Ignore the Bunkers1 and Bunkers2 inputs

### REQUIREMENTS

<!-- Here are a couple servers it works well on:

Omnicron's server: 173.56.27.170:27017 (The large unit set doesn't work here)
Unsmart's server: 89.238.160.112:27017 -->

Propcore. This is on about 30% of servers. For the large unit set, the server must also have HL2:ep2 props enabled.

If you are playing singleplayer or you own the multiplayer server, do this to enable propcore:

1. Install uwsvn: Unofficial Wire-Extras SVN (UWSVN)
2. Type these commands in console to enable propcore:

```
    wire_expression2_extension_enable propcore
    sbox_E2_PropCore 2
    sbox_E2_maxPropsPerSecond 10
    wire_expression2_reload
```
