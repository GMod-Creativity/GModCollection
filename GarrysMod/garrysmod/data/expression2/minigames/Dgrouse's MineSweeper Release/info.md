# Expression 2 - [E2] Dgrouse's MineSweeper Release

## Details

### Author

- Author: DGrouse
- Steam Profile: https://steamcommunity.com/profiles/76561197984369367
- Website: https://dg-collection.weebly.com/expression-2.html

### Publication Info

- Title: [E2] Dgrouse's MineSweeper Release
- Date (dd-mm-yyyy): 06-10-2014
- Source: https://web.archive.org/web/20150508193549/http://www.wiremod.com/forum/finished-contraptions/33602-e2-dgrouses-minesweeper-release.html
- Source Accessed (dd-mm-yyyy): 17-08-2025

## Description

### Details

Sup, I just finished my take on minesweeper for egp, I haven't tested other resolutions besides 512x512 so just leave as is.

Press E on the square you want to reveal.
Press R on a square you think is a mine ( removable )
Press E on an arrow to change the size of the grid for longer or shorter games.
( There is a grace period to stop grid change spam of 1.5 seconds )

If you fiddle with the "Odds" values -1 is no mines, +1 is every square is a mine.

If you fiddle with "Power", that is how many squares appear to the power of 2 ( 5 = 5x5 = 25 squares ).

If you fiddle with Min and Max Power, they change the Power of the grid the arrows will stop at (self explanatory)

### WIFI

To enable wifi, simply set "Wifi" to 1, and give it a name with the "WifiName" variable.
The WifiName can act as a password to stop people from dumping their scores on your router.
Make sure the MineSweeperRouter's "WifiName" is the same as the MineSweeper E2's.

BEFORE spawning your MineSweeper E2s, make the MineSweeperRouter FIRST!!!!!

The chat should print out a message when your MineSweeper E2 has connected.

This feature allows many players to have a go and store each score on the router, if someone else is using the same wifi name on their MineSweeper E2, they will get the score leader and will be able to update their scores to your router.

### Setup

1. Make an egp panel
2. Spawn the e2
3. Spawn the target finder where the player will stand, with a max range of about 30-60.

Wire the e2's EGP to the EGP [wirelink]
Wire the e2's User to the target finder's 1[entity]

### Screenies

THE TYPO HAS BEEN FIXED lol

### Updates

 #1 - Now with colors! \
 #2 - Sounds and gradient \
 #3 - Player Scores \
 #4 - Grid size buttons \
 #5 - Wifi and Score Keeping

### Conclusion

Go nuts.

Mine Sweeper!  
Mine Sweeper Router!

### Re: [E2] Dgrouse's MineSweeper Release

<!-- Interesting! I saw you were part of bitwise development. -->

UPDATE!!!
- Fixed Lose spelling mistake...
- Added player scores and score leader
- Scores are based on how many mines are placed so don't set the odds to 1!
- Power and Odds variables now at the top of the code.
- Scaling the power moves and resizes the new text.
- Be warned, higher Power and Odds can lead to tick quota at default.

UPDATE!!! #2
- Press E on the arrows to change the board size, mins and maxes are kept in the code. (MaxPower, MinPower)
- Press R on squares you think are mines to flag them

NEW UPDATE!!! #3
- New "Wifi" mode, allows you to choose to hold scores on a "Mine Sweeper Router". More features in updated description.
