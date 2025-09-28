# Expression 2 - [E2] Prop Maze Generator [Code heavy/pic heavy]

## Details

### Author

- Author: CloudStrife

### Publication Info

- Title: [E2] Prop Maze Generator [Code heavy/pic heavy]
- Date (dd-mm-yyyy): 14-07-2013
- Source: https://web.archive.org/web/20150824182931/http://www.wiremod.com:80/forum/finished-contraptions/31981-e2-prop-maze-generator-code-heavy-pic-heavy.html
- Source Accessed (dd-mm-yyyy): 10-08-2025

## Description

After being a way from gmod for a long time I decided to re-make my maze generator and release it . . . so here you go.

requirements: SPROPS,WIREMOD

### The Generator

Below is the code that does the maze generation. The main difference between this and others is that the generator can do 3d, use 2 different pathing algorithms, and conserves props. NOTE: you can not copy and paste this into the e2 editor in one go (either copy chunks or paste into a notepad and place into your "GarrysMod\garrysmod\data\Expression2" folder).

### The Menu

So you don't have to hardcode the specifications of each maze i made a holo menu. Right click on the left column to select each option and then right click on each option you want to use/enable. After completing the values you want click the commit button and then spawn the maze generator e2. If you want to change the values manually by hard-coding you must press delete (don't hit commit).

### Step by Step

1. Place the holo Menu e2 down and pick your options. For the Scale values small,medium,large think crawling,walking,driving
2. Press Commit
3. Place the maze generator e2
4. Watch it do its thing

### Algorithms

- Recursive Backtracer/Depth First Search  
This usually yields a main windy path with few dead ends
- Kruskal's Algorithm  
Randomly removes walls until it makes a perfect maze. Makes lots of dead ends but is slower.

- Though rather then explaining what it does I have yet another e2 that shows you how it works with COLORS.

Enjoy!

Note: To solve 3d mazes without the help of other mods / noclip you need to do a DIMZ of 2 and SCALEZ of small to allow you to jump up. Otherwise use noclip
