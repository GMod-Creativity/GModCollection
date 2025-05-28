# Divran's re-railer E2

![hologram train](https://i.imgur.com/Q7pL50l.jpg)

![real train teleported](https://i.imgur.com/0pYpJOy.jpg)

## Crowbar commands
* Left click: Scan train (left click the front main body of the train, the locomotive)
* Right click: Hold this and drag from one side of the rails to the other to start scanning the track
* Reload: After scanning the track, press reload to teleport the train
    
## Chat commands
* .trackwidth (number)

  or
  
  .trackwidth (name)
  * Sets the width of the track (default: 75 source units)
  * Available names: 
    *  "russian" (79.9375 units - will use 75)
    * "2ft" (31.9365 units - will use 28)
    * "standard" (unknown, for now)
  
* .save
  * Scans and saves the train.
  * If you are sitting in a vehicle, will start the scan from the prop the E2 is welded to
  * If you are not sitting in a vehicle look at your front or rear loco/car

* .scan
  * Scans the track for a suitable place to rerail.
  * The chat command scanner isn't as versatile as using the crowbar method. It's only able to find the start of the track
    if the track has nothing blocking it in between the rails.
    If you want to start the scan in an area with something blocking the center of the rails, you should
    use the crowbar method instead.
  * The chat command scanner also can't start in an area where the two rails are "hovering" above the ground (a common issue on sunsetgulch)

* .teleport

  or
  
  .tp
  * Teleports the train to the scanned position

* .crowbar
  * Toggles the use of the crowbar

## Notes
* This rerailer has a few requirements:
  1. The train has at least 2 units, (Loco + cab, Loco + loco, cab+cab etc.) to be scanned. 
    (This limitation is due to model makers not having a standard forward direction for their props.)
    (It can still work for single-unit trains, if the model happens to have a proper forward direction specified by its creator.)
  2. You must select the first (or last) wagon/loco in your train. Selecing any other wagon will not work, and selecting a bogey will break it in strange ways, so don't do that.
  3. Each unit should have bogeys constrained to one base prop.
  4. The train must be positioned in a straight line while scanning and saving the train.
* If the number of constrained entities changes by more than a few since your scan the rerailer will not allow the teleport to occur (for your safety).
* The saved train data will be stored in a gTable, so if you accidentally remove your E2, you can simply respawn it and it'll reload the data.