Author: RedReaper
https://www.youtube.com/@redreaper-xe6so/featured

*MPFC v6 - Flyin' like a badass.*

MPFC, or Multi-Purpose Flight Chip, is a general do-all flight e2 that's surprisingly sophisticated. It's the result of about 6 months of tinkering on and off, with features that seem to be pretty much miles beyond your average flight chip.

This vid is of the almost-done version--I since removed the egp and added the instrument panel, but the rest is pretty much the same
https://www.youtube.com/watch?v=B5JENnLvyVM

Updated: 2/26/2016
From the changelog:
VERSION: 2/26/2016
-fixed freezeself failure--I dun goofed months ago
-fixed the aim/missile hitting shit, by adding dedicated range-agnostic coordinate for flight
-reformatting and massive refactoring for readability and improved performance/safety
-proper GNU style brackest instead of older custom style
-fixed a lot of vars to local scope, as the codebase is particularly old. Shouldn't have broken anything.
-transferred some flag-based items to event-based, so as to reduce CPU/ops overhead
-restructured startup to not have errors and attempt to increase clarity
-removed unnecessary missile check
-ground-hugging radar mode, enter with R+tab or R+L, exit with tab or R+L or a sharp look up, for PLANES ONLY
-new strafe indicator ballistic sight for 3rd person. drifting line you just get over your target and fire, no ranging required.
-reworked ballistic backend to ACF scaling
-properly halts instrument panel updates on 3rd person, to save CPU usage and lag
-changed back the lead computer to mouse/aim based. Fixes some minor bugs.
-crash indicator now updated to 1 seconds, to provide less annoying collision warning
-decreased max zoom slightly to be more practical, it's still zeospanteramode though
-new console screen flight data computer for those who prefer more electronic instruments
-minor adjustments to flight model to make dogfighting less...annoying.
-version namer

So, ground hugging radar (for missile avoidance, think F-111), new 3rd person sight, flight data computer, and of course lag reductions and minor fixes.
This is hte flight data computer, it runs optionally if it's wired and you're in first person view.


To update new vehicles, copy new one over your current copy in your e2 folder. That's it 

Features:
Support for eight types of aircraft, with a template for user extension
Intuitive mouse control similar to war thunder but extended to more aircraft types
A keyboard-only control backup, for turreted gunnery or general freelook
Easy setup, just a chip, pod, cam, an (included) e2 that acts as a data-bank, optional adv e marker
Camera magnification of 1x, 2.5x, 5x and 50x (long range spy camera)
Realistic autolevel for bombing or hovering, operating off inertial sensors
Damage mode that supports crashes and loss of structural members
Support for four weapons plus missiles/bombs/rockets
Low altitude mode for ground-skimming aircraft
Full (optional) holographic flight instrument panel
Full (optional) console digital screen flight computer
Support for fire missions--via chat, friends or yourself can designate a target of interest
Waypoint autopilot with either chat commands (same as mpfc 3)
Autopilot ability to simply fly a route and have the airframe loop over it (for drones or CAS)
Low-lag lead and drop computing gyro gunsight using extremely accurate ballistics (as accurate as most RK4 solutions but running off range tables, so less CPU usage), with automatic ranging.
Chat command detail prop stripping for high-lag environments
Support for monocoque vehicles--no "50k base" shit, it will scale almost infinitely and you can use guns as parts of your structure
Outputs for landing gear down & brakes, thruster afterburners, WEP effects, missile reloads, and two aux outputs for special equipment
Relatively easy server impact thanks to some serious fucking deep magic here.
Enforcement of acf pod rules--you cannot fly if you have weapons & a non-acf legal seat
Code structure built around user modability, for community extension. No more "black box" style coding.
Uses @autoupdate so updates can be posted
Instructions & documentation at the top of the code, variable library at the bottom.

Special thanks to fervidusletum, he did some guru work on the autogyro mode, making its instructor work well and balancing its scheme entry.

Some stuff made with it!
Dogfights on frs

A vid to help with setup if you don't for some reason get the instruction in the e2. Should cover both basic setup and a few more advanced features. I spent a lot of time writing that damn documentation!
https://www.youtube.com/watch?v=ME7bGVOLtgI