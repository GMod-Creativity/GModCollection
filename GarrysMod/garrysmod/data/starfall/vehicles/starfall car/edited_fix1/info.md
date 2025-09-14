# Starfall - [GMOD STARFALL] Car (Edited)

## Details

### Author

- Author: galaxy (ZeroTut0rials) (GDOGS)
- Steam Profile: https://steamcommunity.com/profiles/76561198128391261
- YouTube: https://www.youtube.com/@ZeroTut0rials

### Edited

- Edited: EnoSkyFire
- Edited Date (dd-mm-yyyy): 26-08-2025

### Publication Info

- Title: Starfall Car
- Date (dd-mm-yyyy): 30-03-2022
- Source: https://pastebin.com/p2PK7v33
- Source Accessed (dd-mm-yyyy): 25-08-2025

## Starfall Car

Changed `0` at the end in line 5:

```plaintext
    local E = prop.create(chip():localToWorld(Vector(0,0,0)), chip():localToWorldAngles(Angle(0,0,0)), "models/sprops/rectangles_thin/size_66/rect_66x120x1_5.mdl", 0)
```

To `false`:

```plaintext
    local E = prop.create(chip():localToWorld(Vector(0,0,0)), chip():localToWorldAngles(Angle(0,0,0)), "models/sprops/rectangles_thin/size_66/rect_66x120x1_5.mdl", false)
```
