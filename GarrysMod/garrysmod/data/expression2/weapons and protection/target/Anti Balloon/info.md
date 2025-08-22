Author: Stress
Date: 12-29-2014
Title: [E2] Anti Balloon

*[E2] Anti Balloon*

Hello guys,

This is the first time I post one of my Expression 2.
I'm am sharing this to help players understand a bit the find method.

This Expression 2 is pretty helpfull to me when I play on multiplayer servers, and kids spawn balloons everywhere. (weapons are disabled most of time)

Just make sure to not place it behind walls or it will shoot the walls.

How to use it :

First step : Create a wire turret.
Second step : Spawn the e2 chip.
Third step : Place the e2 chip where you want with your physgun.

You can also use this for the Fire = 1 & 0.

Code:
O = owner()

if ( changed( O:keyPressed("X") ) & O:keyPressed("X") ) {
    Fire = 1
} else {
    Fire = 0
}

Edit Note :
    Moved :
        Code:
        E = entity()
        EP = entity():pos()
    Added :
        Code:
        Turret:createWire(E,"Fire","Fire")
    Removed :
        4th step from "How to use it :" .

Informations :
OPS : 40-55
Addon(s) used : setPos
