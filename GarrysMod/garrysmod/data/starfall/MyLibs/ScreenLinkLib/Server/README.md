# Screen Link Server Library For Starfall

## Example: Link a single screen to the starfall chip

Spawn a starfall screen and run the example to connect the screen to the starfall chip.

```lua
--@include esf_libs/link/link_screen_sv_v0.2.txt
local screenLinkLib = require("esf_libs/link/link_screen_sv_v0.2.txt")

-- Link single screen to the chip
screenLinkLib:linkSingleScreen()

-- Print the linked components of the chip
printTable(chip():getLinkedComponents())
```
