## Background
[Garry's Mod](https://en.wikipedia.org/wiki/Garry%27s_Mod) is a video game by Facepunch, published by Valve in 2006. It is a [sandbox game](https://en.wikipedia.org/wiki/Sandbox_game) built on the [Source Engine](https://en.wikipedia.org/wiki/Source_(game_engine)) originally as a mod, and Gmod itself supports many mods. One of these is [Wiremod](https://github.com/wiremod/wire/wiki) by the WireTeam, which adds logic gates, sensors, inputs and outputs, and programmable chips such as [Expression 2](https://github.com/wiremod/wire/wiki/Expression-2).

Expression 2 is an interpreted language that could be described as a mix of C and Lua. It is a powerful way to interact with the game, being able to spawn entities, remotely apply forces, and has full knowledge of and access to all of the entities and players on the server.

## Repository
I wrote the files here in 2013 during my time as an administrator on PonyLiving (a community Gmod server), though I've cleaned up and simplified some of the code. The original files can be seen in the commit hstory.
|Name|Description|Picture|
|---|---|---|
|[Chat Monitor](Chat_Monitor.txt)|Logs chat with timestamps, can be viewed with a debugger, has display options set through chat, and can save to disk|[![Chat Monitor](https://i.imgur.com/UaE0kFM_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/UaE0kFM.png)|
|[Fading Door](Fading_Door.txt)|(Unoptimized) Grants entry to whitelisted players, with chat commands for adding/removing players and owners|[![Fading Door](https://i.imgur.com/JlSs2GX_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/JlSs2GX.png)|
|[Flying Prop](Flying_Prop.txt)|Should be attached to a prop, will chase a specified player declared by a chat command|[![Flying Prop](https://i.imgur.com/QyyGbFf_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/QyyGbFf.png)|
|[Hologram Base](Hologram_Base.txt)|Large rotating hologram to help players find the base from afar|[![Hologram Base](https://i.imgur.com/jGGuKSx_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/jGGuKSx.png)|
|[Hologram Icosahedron](Hologram_Icosahedron.txt)|Rotating icosahedron hologram with changing colors that spins faster as a player approaches it|[![Hologram Icosahedron](https://i.imgur.com/ec9AgIE_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/ec9AgIE.png)|
|[Player at Door Detector](Player_at_Door_Detector.txt)|Displays info about the nearest player onto a text screen, optionally excluding yourself|[![Player at Door Detector](https://i.imgur.com/meaBRj3_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/meaBRj3.png)|
|[PLOTS](PLOTS.txt)|PonyLiving's Own Trivia Show, an incomplete project based on Jeopardy|[![PLOTS](https://i.imgur.com/6dEQHON_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/6dEQHON.png)|
|[PLOTS State-Machine](PLOTS_State-Machine.txt)|Incomplete re-write of PLOTS based on status IDs|[![PLOTS State-Machine](https://i.imgur.com/EMVvGv3_d.jpg?maxwidth=520&shape=thumb&fidelity=high)](https://i.imgur.com/EMVvGv3.png)|

![Main screenshot](https://i.imgur.com/deFZNQt.png)
