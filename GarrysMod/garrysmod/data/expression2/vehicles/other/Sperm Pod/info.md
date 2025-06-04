- Author: Chaquator

Sperm Pod:
- Date: 05-28-2014
- Title: [E2] Sperm Pod!

## Sperm Pod!
So I made this E2 so long ago, and I never really intended on releasing it, but everyone else posting really blew my load, so here.

It's the Sperm Pod.

W and S make it move forward and backwards.
Shift reduces the speed of it moving forwards and backwards.
A and D make it turn left and right.
Space and Alt (or whatever your walk key is binded to) to tilt the Sperm Pod up and down.

This E2 was not one that I intended to release, as I mentioned earlier, so the code is much less polished than a code of mine that was meant to be released would be.

NOTE: IT RUNS AT ABOUT 2700 OPS

Last edited by Chaquator; 07-10-2014 at 07:08 PM. Reason: updated formatting

Sperm Pod V2:
- Date: 01-19-2015
- Title: [E2] Sperm Pod V2

## [E2] Sperm Pod V2

To get it to work:
1. Spawn a chair
2. Spawn a Cam Controller with the following settings checked/unchecked:
   - Coordinates local to parent checked
   - Client side movement checked
   - Localized movement unchecked
   - The rest can be checked to your liking
3. Link Cam Controller to your chair
4. Spawn E2
5. Wire P [ENTITY] to the chair
6. Wire C [WIRELINK] to the Cam Controller
7. Hop in
8. Enjoy

I coded it in a new way I learned from Divran's 2 codes I've seen him make. It does a bunch of else-if statements on anything that would trigger the E2 to run and such, which is really cool and optimized.
