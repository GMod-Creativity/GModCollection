- Author: Tolyzor
- Date: 09-07-2014
- Title: gm_trainset onboard setPos switch control

gm_trainset has 150 switches, and you constantly have to exit the train to throw them, as most are manual.

This e2 lets you use one key to throw the switch in front of your and another to throw the switch to your rear, anywhere on the map.

Each section of track is divided into a "block", defined by waypoints. Each block has entry and exit switches who's order is defined by the direction you entered the block

Instructions:

1. Weld the E2 to your train, not more than ~50 units from the tracks.
2. Spawn a wire user, and freeze it facing downwards. Do not weld the user to anything.
3. Wire the user to the E2 "User:entity" input, and wire the user "Fire" input to the E2's "PressUse" output.
4. Wire the E2's "ShiftEntrySwitch" and "ShiftExitSwitch" inputs to keys of your choice.
