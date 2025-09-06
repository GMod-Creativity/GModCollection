# Distribution Release
A combined repository of Ultracoin, Ultramove, and the accompanying PAC3 for Garry's Mod.

These Expression2 Scripts port Ultrakill's Marksman/coinshot ability to Garry's Mod as well as the movement tech.

Clicking 2 separate tabs of Github is too hard for some of the people ive met, so I put everything in one place.

Also a single git clone command saves time and keystrokes.

# The PAC3
provides sliding animation, viewmodel, and HUD. And works in tandem with the E2s.

# Installation
Just clone in, SSH, or pull the zip file.

Drop Ultracoin.txt into ProgramFiles/Steam/Steamapps/Common/GarrysMod/garrysmod/data/expression2

Same for Ultramove.txt

But put V1PAC3 into the pac3 folder    Steam/Steamapps/Common/GrarrysMod/garrysmod/data/pac3

UltraNerd is just for if you want to read up on some of the things going on within the script.

# Intallation Explained
First make sure you have Wiremod, Plycore, Antcore and Nexuscore installed through the workshop.

Propcore is already inside of Wiremod but must be enabled by commandline.

Download ultracoin as a zip file using the "code" dropdown in github, colored as a green box.

If opening Garry'sMod directory through steam, right click the game in the library, go to properties, local files, browse local files. Then navigate the folders to get to "Garry'sMod/garrysmod/data/expression2"

Place the script text files into the expression2 folder.

If your game was already running, open the wire tab of your spawnmenu, open the Expression2 tool, and click "update" to refresh all available script listings so that the recently added scripts now show up.

Both Ultracoin and Ultramove go into the steam/steamapps/common/Garrys Mod/garrysmod/data/expression2 
Folder

But the PAC3 file included in ultramove.zip needs to be placed into Garrys Mod/garrysmod/data/pac3


A few necessary in-game console commands are

wire_holograms_modelany 1

wire_expression2_extension_enable propcore

wire_expression2_concmd 1

The first command allows the new vfx for coinshot to show, the second allows it to even work, and the third allows the movement E2 to play the PAC's sliding animation on your playermodel

# Installation hyper-abridged% speedrun

You literally just open a terminal in the expression2 directory, run a git clone command and forget about it.
Resync every now and then to get updates.
V1PAC3 -> pac3

ez

# Dependencies
Propcore

Plycore

Antcore

Nexuscore

PAC3

Wiremod (ditto)

TF2 (optional for alt tracer)

## If you don't have Team Fortress 2 installed.
Then change the E2 setting relating to TF2 Trail to the value of zero

# DevConsole Dependencies
wire_holograms_modelany 1

wire_expression2_concmd 1

wire_expression2_extension_enable propcore


# Ultracoin Usage:

Right click when holding 357 to toss coin, up to 4 times. After a slight delay, you can shoot your coin. Struck coins will target other coins and players.

If someone else chucked a coin, shoot it before they can to totally meme them.

THE MORE COINS CHAINED, THE HIGHER THE END DAMAGE.

So while throwing more coins will guarentee a kill most of the time, having a big cluster of coins in the air is easier for opponents to shoot and make all that damage go to you.

Coins will recharge over time and you will receive a notification.

Add players to blacklist and whitelist so you can choose who is targetted.

Coins can be punted with Gravity Gun for extra range


# Ultramove Usage:

Dash with your sprint key up to 3 times before 1 use recharges every 1 second.

Slam by using your crouch key when airborne.

Slide by holding your crouch key while on the ground. You will begin sliding in the direction you are looking if not moving. If moving, you will slide in last held movement direction.

# Advanced Movement

Slam Storage can be performed by slamming into a simultaneous walljump, and then pressing & holding jump key when touching ground. This will throw you into the stratusphere.

Slide Hopping can be performed by starting a slide then jumping shortly after. On Sanctuary, looking behind where you are sliding before jumping will yield greater velocity.

Dash Hopping can be performed by jumping mid-dash, sending you a great distance.

# Advanced Marksman
The fabled "Orbital" as conceptualized by yours truly, and utilized in practice by HerbMessiah is possible.
If you throw a coin and are able to punt it with the gravity gun, you can launch the coin to space. Or across Gm_Bigcity for that matter.
Throwing another coin closer to you and then shooting it will cause a chain to the furthest coin and completely meme someone from a range and angle they had no chance at predicting.

# Credits:
## Katsu
For making basically all of this possible. Thank you for making the awsome holos, algebraic hit detection, fundamental damaging method both in bottled form and antcore, chaining, countering, and grazing functions.
You have also done a wonderful job making the sliding function, stamina, walljumps, and dashing.
This E2 is basically your baby. And as such you have raised it right by protecting it from bad influences, and have hardlocked certain variables so skids cant abuse them. You have honestly thought of quite genius solutions to the way this can damage a player and impressed the hell out of others working on this.

## Anane
For being the first person to accept the challenge of making this E2. I still appreciate you even though the furthest youve gotten was the initial coin holo and throwing arc. You practically built the foundation Katsu would build upon before he even knew what Ultrakill was. You have no idea how much it means to me that you and Katsu helped make not only MY dream come true nearly a year ago, but unknowingly layed the building blocks of a project many players will come to love.

## Heckteck
For making the whitelist/blacklist and FFA/TDM functionality. You also allowed the Coin to be puntable by the GravityGun for skillshots and made the momentum-imparted cointoss function to make sure it was accurate to Ultrakill. The momentum impartion not only helps accuracy of the coins portrayal but greatly increased skill ceiling of its usage in PVP. Thank you.

## GoldenFlare
For adding backspin to the coin, and laying out the plans for ping compensation to yeild better hit detection and consistency. Thank you again for adding SLAM STORAGE and SLAM BOUNCE tech to the movement script. I feel the liveliness of PVP with this E2 will be partially indebted to you and the changes you plan on making in the future.

## Runic
For adding an antispam. You have added a comprehensive block to the code I am very thankful for. By making it to where a player cant just shoot the coin on the flick-frame. You brought balance to an otherwise chaotically mingy E2.

## Death
For creating the PAC HUD, Slide animation, Viewmodel and providing valuable input.

## Panny
For creating the flick anim in the PAC's first person viewmodel. It looks beautiful. I fucking love it and I know others will too.


### Omni, Gamerweed69, 'Gunt Master', RadioJackal, 'FaZe 360 = Disconnect', Sealife, c0wm4n, Gespa, Taursen and many others.
For inspiring me, supporting this project, offering valued input, playtesting the scripts, and contributing minor tweaks where needed along the way.
You were as appart of this 8 month and running journey as everyone else here.
Thank the Fuck out of you <3 

