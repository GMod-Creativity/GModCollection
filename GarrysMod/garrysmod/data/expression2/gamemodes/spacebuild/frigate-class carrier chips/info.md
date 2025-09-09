# Expression 2 - Fearsome spacebuild frigate-class carrier

## Details

### Author

- Author: Paper Clip (glmcd) (glmcdona21) (glmcdona)
- Steam Profile: https://steamcommunity.com/profiles/76561197990877852
- YouTube: https://www.youtube.com/@glmcdona21

### Publication Info

- Title: Fearsome spacebuild frigate-class carrier
- Date (dd-mm-yyyy): 06-04-2010
- Source: https://web.archive.org/web/20110425081431/http://www.wiremod.com/forum/finished-contraptions/19276-fearsome-spacebuild-frigate-class-carrier.html
- Source: https://www.youtube.com/watch?v=48gGbpWWWrM
- Source: https://www.youtube.com/watch?v=8eaJpYEybpw
- Source: https://www.youtube.com/watch?v=SE7PfgocE6o
- Source Accessed (dd-mm-yyyy): 25-08-2025

## Description

<!-- **EDIT: SIMPLIFIED E2 AND USAGE INSTRUCTIONS for carrier_fighter_controller_simplified.txt:**

Download this e2 file: carrier_fighter_controller_simplified.txt

I added a simplified version of the fighter control e2 chip to the post, feel free to make your own carrier! This is really easy to use and this e2 will work on any server with up-to-date wiremod.

### Chat Commands:
- orbit -> This tells the fighters to take off and orbit your carrier.
- land -> This tells the fighters to land.
- attack {name or part of name} -> This tells the fighters to attack the specified player. Eg. "attack Pap" would tell them to attack me, Paper Clip.

### Here is how it is wired up:

- @inputs Mouse1 Mouse2  
Wire these from your adv. pod controller. Mouse 1 will order the fighters to attack any prop it finds forwards from the carrier. Press mouse 1 again to recall the fighters. I don't think Mouse 2 does anything.

- @inputs ParentLink:wirelink  
Wire ParentLink directly a prop on you carrier. This prop should have :forward() direction being the forward direction of your carrier. It only uses this input when you press Mouse1 and it searches for targets.

- @inputs [F1 F2 F3 F4 F5 F6]:wirelink  
Wire this up directly to the smallest of the PHX Transportation prop jets. F1 if fighter #1, F2 is fighter #2 ect. If you want to make different looking fighters, just build your fighter parented to this jet model and make it invisible.

- @inputs [L1 L2 L3 L4 L5 L6]:wirelink  
Wire this up to the landing props. L1 is the landing prop for Fighter #1, it lands where this prop is and orients itself with it when docked. It is best to use a small prop like a helibomb prop.

- @outputs Fire1 Fire2 Fire3 Fire4 Fire5 Fire6  
These are the fire signals for each of the fighters. If Fighter #1 is attacking someone and it gets a valid ranger hit on the target, it will set Fire1 to 1.

- @outputs Targ1:entity Targ2:entity Targ3:entity Targ4:entity Targ5:entity Targ6:entity  
These are the entities that each of the fighters are attacking, this can be used as inputs to weapons that take an [ENTITY] input.

- @outputs XYZ1:vector XYZ2:vector XYZ3:vector XYZ4:vector XYZ5:vector XYZ6:vector  
These are the XYZ coords that each of the fighters are attacking, this can be used as inputs to weapons that take a [VECTOR] input.

**ALSO NOTE:** You need to repaste the e2 for it reload the fighters. So you need to wire the fighters up, then update the e2. It waits about 10 seconds before initializing, this is to avoid initializing while your carrier is still pasting. -->

### Description

This is a fearsome frigate-class carrier spaceship built for serious spacewar pwnage :) I don't recommend trying to get the attached dupe to work on the server you play on, it has quite a few server requirements (See dupe requirements section). Feel free to steal or modify the e2 chip to build your own carrier on your spacebuild server.

### How it Works

- Single E2 chip for controlling all 6 fighters using applyforce running at tick 50 and ~600 ops. This E2 is approximately 500 lines of code and includes basic obstacle avoidance.
- E2 applyforce chip for the flight system of the carrier itself. (See [http://www.wiremod.com/forum/contrap...sign-chip.html](https://web.archive.org/web/20110425081431/http://www.wiremod.com/forum/contraptions-saves/17737-applyangforce-system-identification-dead-beat-controller-design-chip.html) for details)
- E2 chip for point defense against missiles, not shown in movies but included in dupe.
- E2 chip for life support system.

### Dupe Requirements

The dupe has quite a few server requirements to work:

- LS3
- Custom Addon Framework with Laser-Systems: for the lasers transferring the power from carrier to the fighters.
- Weapons: Unique to server: [McBuild Server Info (ip addresses, svn links, map links)](https://web.archive.org/web/20110425081431/http://mc-builds.org/showthread.php?))2704-McBuild-Server-Info-(ip-addresses-svn-links-map-links)
- Prop core: For welding the fighters to the carrier during flight.

### Advanced Dupe

Save the file attached to this post to this folder:  
C:\Program Files\Steam\steamapps\<userName>\garrysmod\garrysm od\addons\Adv Duplicator  
Then use the Adv. Dupe Tool in-game to upload it to the server and paste it.

### Three Battle Videos!

***Thanks to opponent spaceship commanders D4RK3_54B3R.dat and Katelyn*** :)

Newest Video:
https://www.youtube.com/watch?v=48gGbpWWWrM

Somewhat New Video:
https://www.youtube.com/watch?v=8eaJpYEybpw

Old Video:
https://www.youtube.com/watch?v=SE7PfgocE6o

### E2 Code

#### Fighter Controller Chip

This controls all 6 fighters.

- **Inputs:**

    ```
    Energy <- Energy output of resource cache on a single fighter
    Energy Max <- Energy Max output of resource cache on a single fighter
    Parent:entity <- {Wire->Detection->Entity Marker} linked to the main prop of the carrier. This is used for welding when docked.
    Mouse1 <- Adv. Pod Controller Mouse 1. This tells the jets to attack.
    F1_LasRec:wirelink <- Wired from a wirelink on Fighter #1 Laser Receiver.
    F1_Las:wirelink <- Wired from a wirelink on Fighter #1 Laser. The laser is a laser beam welded to the carrier which transfers power to the laser receiver above. The docked position, takeoff, and landing for fighter #1 is determined by the position and orientation of this laser.
    F2_LasRec:wirelink <- Same as above except Fighter #2.
    F2_Las:wirelink <- Same as above except Fighter #2.
    ...
    ```

- **Outputs:**

    ```
    Laser -> The lasers sending power to all of the fighters.
    Fire1 through 6 -> Wired up the guns on fighters 1 through 6.
    Targ1:entity -> The entity that fighter #1 is currently targeting. This is used as input for special guns which take a target entity input.
    XYZ1:entity -> The position that fighter #1 is currently targeting. This is used as input for special guns which take a target entity input.
    ```

#### Carrier Flight System

- **Inputs:**

    ```
    Seat:entity <- Wired from adv. pod controller.
    ```

- **Outputs:**

    ```
    CamEnable -> Adv. Cam Controller
    CamPos:vector -> Adv. Cam Controller Position
    CamDir:vector -> Adv. Cam Controller Direction
    ```

#### Carrier Point-Defense System

- **Inputs:**

    ```
    Fire <- I wire this up to Mouse2 on Adv. Pod Controller. This forces the beam cannons to fire.
    Ship:entity <- This is the main prop on my carrier.
    Gun1:wirelink <- A wirelink to beam cannon #1.
    Gun2:wirelink <- A wirelink to beam cannon #2.
    ResourceNode:entity <- A wirelink to my carrier resource node.
    Spin1 <- Output from bean cannon #1.
    Spin2 <- Output from bean cannon #2.
    ```

- **Outputs:**

    ```
    FireOut1 -> Output to beam cannon #1 fire
    FireOut2 -> Output to beam cannon #2 fire
    ```