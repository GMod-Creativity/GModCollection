- Author: DGrouse
- Date: 10-06-2014
- Title: [E2] Dgrouse's MineSweeper Release

**Details**
Sup, I just finished my take on minesweeper for egp, I haven't tested other resolutions besides 512x512 so just leave as is.

Press E on the square you want to reveal.
Press R on a square you think is a mine ( removable )
Press E on an arrow to change the size of the grid for longer or shorter games.
( There is a grace period to stop grid change spam of 1.5 seconds )

If you fiddle with the "Odds" values -1 is no mines, +1 is every square is a mine.

If you fiddle with "Power", that is how many squares appear to the power of 2 ( 5 = 5x5 = 25 squares ).

If you fiddle with Min and Max Power, they change the Power of the grid the arrows will stop at (self explanatory)

**WIFI**
To enable wifi, simply set "Wifi" to 1, and give it a name with the "WifiName" variable.
The WifiName can act as a password to stop people from dumping their scores on your router.
Make sure the MineSweeperRouter's "WifiName" is the same as the MineSweeper E2's.

BEFORE spawning your MineSweeper E2s, make the MineSweeperRouter FIRST!!!!!

The chat should print out a message when your MineSweeper E2 has connected.

This feature allows many players to have a go and store each score on the router, if someone else is using the same wifi name on their MineSweeper E2, they will get the score leader and will be able to update their scores to your router.

**Setup**
1) Make an egp panel
2) Spawn the e2
3) Spawn the target finder where the player will stand, with a max range of about 30-60.

Wire the e2's EGP to the EGP [wirelink]
Wire the e2's User to the target finder's 1[entity]

**Screenies**
THE TYPO HAS BEEN FIXED lol


**Updates**
#1 - Now with colors! \
#2 - Sounds and gradient \
#3 - Player Scores \
#4 - Grid size buttons \
#5 - Wifi and Score Keeping

**Conclusion**
Go nuts.

Mine Sweeper!
Mine Sweeper Router!
