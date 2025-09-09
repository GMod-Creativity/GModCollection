# Expression 2 - Techni's A* PathFinder

## Details

### Author

- Author: Technicolour (Techni)
- Steam Profile: https://steamcommunity.com/profiles/76561197983168201
- YouTube: https://www.youtube.com/@Technicolour777

### Publication Info

- Title: Techni's A* PathFinder
- Date (dd-mm-yyyy): 25-09-2009
- Source: https://web.archive.org/web/20110118003949/http://www.wiremod.com/forum/finished-contraptions/14611-technis-pathfinder.html
- Source Accessed (dd-mm-yyyy): 04-09-2025

## Description

Over the last couple of days I've been working hard on my pathfinder, it uses the basic A\* method of finding the quickest path from A to B. I've seen a couple of other path-finders around these parts, Bulls path-finder is very impressive and is what inspired me to do this, hoever (Although having not looked at his code) I don't believe his uses A*, rather another method, which, while definately faster I'm not entirely sure guarantees the shortest path.

<!-- Techni's PathFinding - Xfire Video -->

Although my method uses a grid the entire grid is not stored in the arrays, rather only the points that have been checked. This means that there's no possibility of checking an already checked point and that the array sizes don't explode for large searches. This pathfinder can do pretty large searches in both 2D and 3D without exploding, although keep in mind the larger and more complex the search the longer it will take, it's possible to decrease the accuracy for faster pathfinding.

This pathfinder will handle 2D and 3D problems without issue (Although 3D problems take notably longer) of nearly any size, although the maze in the video is about 150 'path-finder' size grid-lengths by 150 (22,500 in total) only 2300 points are stored over 2 arrays by the end of the search.

More videos and the E2 code to come.

#### Improvements to be made:

1) Cut the nodes out of the final path that aren't needed, join nodes with lines between.
2) Have a holo tank follow a path.
3) Optimize

---

### Re: Techni's A* PathFinder

```
Quote Originally Posted by l3ulletje
Very nicely done.
```

Mine uses the same storing the visited points system.

It simply goes in the direction an available point which is closest to the end. That is A* right?

A\* uses that but in addition it keeps track of the distance along the path it's gone. F = H + G where G is the total path length to the point, H is the manhatten distance to the target (At least for mine, where it only uses the primary 4/6 vectors to search), aka the heuristic.  
If I read correctly your uses Best Search First (F = H), the advantage of this system is that it is much faster, the disadvantage is that it doesn't guarantee the absolute shortest path possible. If you already have a F = H system in place it shouldn't be too hard to get an an A* system in place without changing much code. (Grab the 'G' from the last node and add the distance from that node onto it, then just add this number to H.)

This image demonstrates the differences between the systems:  
see concave2.png

The blue line being A* and the red line being Best Search First.

---

### Code Release!

A few things to take note of:  
GPS is the vector of the position you wish to find.  
GridSize is the distance between nodes, a larger grid will run faster but will miss potential paths. A smaller grid size will run slower but find smaller gaps for paths.

Unhighlight the first holocreates to see the pathfinding process in action.
A high 'weight' will increase path accuracy at the expense of speed, a low weight will increase speed at the expense of path accuracy. A weight of 0.7 or so is guaranteed to find the shortest path in the shortest time on average.

To run in 2D simply delete/commentout the last two VecArray entries. 2D isn't entirely finished, the GPS and Expression must be on the same 2d plain.
This is the first version ready for public release, it's not particularly user friendly but it gets the job done.

<!--New Video, larger maze:
PathFinder Mazesolver - Xfire Video

Trouble finding T-Spawn?
PathFinding de_prodigy - Xfire Video -->

#### Further improvements to be made:

- Optimizations
- Put Final path nodes into seperate array for usage by a holotank, and for easly cutting out the inbtween nodes.
