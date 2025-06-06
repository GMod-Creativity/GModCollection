- Author: RedReaper
- Date: 07-30-2014
- Title: Red's Useful E2s Thread

## Red's Useful E2s Thread*

Since I'm tired of making a thread for every damn tool I make, I decided to just make this thread here. This covers a lot of em, some I'm sure you've probably seen.

**Steering Wheel and Gauges**
Holo steering wheel with 3 gauges and ignition. Should be self-explanatory as to how to set it up. It's built off an old dupe actually, you can adjust the steering wheel angle, size, how much it turns, and its model.
The gauges have a red needle each, which works only when driving, the ignition key switches on and off, and the wheel turns in direct proportion to your input. Pretty darn simple. I've been having computer issues, so I haven't gotten to test it well, but it should be fine.

**Holo Shock Absorber**
Holo springs! Two types of leaf, a shock, and a coil spring
Shock absorber, not pictured. Pretty self explanatory. Creates a shock at a fixed angle, of user defined width and length. Will not expand beyond shock model limit, will not compress beyond shock model limit.

**Reds Holo Coil Spring**
Coil spring. Creates a holo coil spring; you can define how many coils you want (uses sprops bodygroups). It does not extend past that initial length, though, it does compress. This keeps it from behaving "oddly". It has to have the coil below the prop; this is relative to prop, not world, so it DOES work at any angle, just have to parent its "base" properly.

**Reds Holo Leaf Spring - Single Point**
Leaf spring. This creates a single fixed leaf spring. It rescales appropriately, and moves to be "between" the chip & the end point, so it appears as if it is a fixed leaf spring. This will support sprops leaf models of around leaf_36 to leaf_48, and KINDA works below it, it's not supported on tiny springs. Great for like old cars, or 4x4s. The leaf spring doesn't twist, or move backwards. This is intentional, as with the coil spring, to make it behave more realistically in use. It also imposes limits on how far it "moves" relative to its own size, so you don't get weirdly thick springs at moments--it'll instead appear as if your axle is no longer on its spring.

**Reds Holo Leaf Spring - Two Point**
Two point leaf spring. This one pivots between two end points. This is designed for leaf spring bogies, like the rear axles of 6x4 trucks, where one leaf spring handles two axles, or for tanks. You can also use it on old car front axles. It can be used, if you desire, for a single axle, by making there two "shackle points" on your vehicle and attaching the chip to the axle.

**Simple Turret Chip V1_1**
This is a simple aim chip. It is intended for remote turrets, but will work with regular tanks. Users of chips like my old simple aim chip, or my old remote turret chip, or the generic gyro will feel at home--this chip adds e2-based angular limiting and a much more realistic control system.
Though I've never been a big fan of e2 angle limiting, it is added because the other new feature on this is hull-influenced turret rotation. Instead of your turret spinning happily while your tank maneuvers, turning your hull actually affects your turret, like in world of tanks or war thunder. This will hopefully help even out ACF's playing field. It also measures angular change in degrees per second, so you can more realistically tweak tanks. You'll find that even with a very slow turret traverse speed, by moving your hull it is extremely hard for enemy vehicles to flank you (doubly so for me, since my transmission has aim-based steering as an option lol) The code is deliberately very well spaced, formatted, and with ample annotations, to help anyone who wants to mod it or learn from it.

**Simple finder bringer**
This finds and brings to you all the chips of the model you attach it to. So, like if I attach it to a 1x phx bar, ALL my 1x phx bars spawned will immediately come up in front of me. It's kinda useful for niche tasks, I've so far only needed it once or twice.

**Reds holo scaler doodad**
This is a holo scaler, it's a lot more useful than like scaling 1 holo part by adjusting the code, instead you just use numpad to scale the holo, and E+numpad to scale it faster. R outputs to chat the size and prop, so you can copy it into your code.

**Propellor**
This one's a propellor, it'll take different sprops small propellor models or the two phx propellors for planes. It works with my flight chip too, and has a simple disc effect when running. The inputs should be pretty self-explanatory--Active is if the engine is running, throttle is 0-100.

**Build Bucket**
This is my "build bucket", it's a building assistant intended to streamline the build process. This bugger is almost 1,000 lines, and a mammoth of a project that's spanned two iterations--"Factory In A Can" came before it. It works with my install of propcore, but it may not work for yours--I have omnomicron's latest build AND Ptugasantos's AND propcore in singleplayer, and it works only there. I'm releasing it with no technical documentation or support offered at the moment, but I will probably refactor to run on ptugasantos's in the near future.
Currently, it can do the following functions all at once:
Multiweld hulls
Constrain most types of suspensions
Apply elastics to all roadwheels
Rope-turret mount turrets, and balance them with counterweights and multiple guns
Apply "bump stops"
Nudge wheels all together up/down/in/out
Set physprop_material for all wheels
Applynocollides and nocollideallmulti
Align wheels like for my track chip
Unparent weldparented acf engines, gearboxes, or fuel tanks
Move a prop as a mantlet for the gun on your turret

**Cupola**
It has built-in help, to instruct you very basically how to use it. Again, it may work partially or not at all for you, it is ENTIRELY a beta.

This is a simple holo hatch/cupola, that you can rescale and add to tanks. You can change the colors inside of it, and change its material just by rematting it and resetting it if not duped. Good for tanks, subs, etc.

**Airship balloon**
This creates a simple airship balloon holo, which you can rescale, recolor, or remat. To give the balloon a mat, apply it to the chip itself and reset; color and size are set in the e2. It's useful for saving 150 phx props, and doesn't include fins on the rear so you can customize it.

**MedDoor**
This is a door, works like the cupola above. Like the cupola, super low in lag, useful for something that is a detail prop. The cupola defaults to open but closes when activated (like the cupola on a tank, using cam controller), but this instead defaults to closed and opens on command.

**Travel Lock**
This is a simple tank gun travel lock. It just flips up when activated. I use it occasionally since my aim e2 (not to be released in the near future or probably ever) has a feature like a real travel lock.

**Reds Nompad**
My "nompad", a replacement for numpad. it can be linked to a pod, which numpad can't, making it useful for stuff like "wot style" ammo switching. It's already got its own thread, but I'm moving it here for consolidation.

**Parented seat ejection fixer**
My "parented seat e2 fixer", makes it so anyone in a pod in the constrained contraption can get out with E even if the seat is parented. Fixes an old gmod bug where parented seats you sometimes couldn't get out of them. This has its own thread, but I moved it here, to consolidate.

**End**
I'll update this thread with more stuff in the future, as I write it all out. A lot of these are older, unreleased bits. I'm switching a lot of my "spare time coding" to other languages and applications, but I still might make more stuff.

If you have a good idea, and it's useful or somehow beneficial for the community, feel free to request it below (Good example: "why not an e2 that I can use to make a race course appear?" Bad example: "code me a hovering plate that shoots lazors!")
