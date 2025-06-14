Author: Technicolour
Date: 06-02-2011
Title: Intel 8080 Emulator (Feat. Arcade Space Invaders)

This is a fully fledged Intel 8080 Emulator, nearly everything is Emulated.

Although the 8080 core itself is generic, things such as memory, video, and input/output are of course device specific. In this case all of those elements are from that of Space Invaders, which uses a very simple 1bit display and flat memory and a simple I/O shift register for shifting 16 bit integers, which the 8080 is otherwise not capable of.

Although Control Input would be very easy to implement, I've not done so as it's just too slow, what you're seeing in the video is "attract mode", which is where the arcade machine runs on its own to, you guessed it, attract potential customers.

The E2 code isn't optimised at all, especially the if-stack which is over a couple of hundred long. Optimising this code by nesting it into a quad or binary tree in addition to sorting in order of occurrence would see a performance increase in the range of 10-20 times but making modifying, debugging and reading the code considerably more difficult so I opted not to do it until the product is fully finished (likely never, hence why I'm releasing this now).

There's a bug in it currently which causes the sprite writing subroutines to write to an offset piece of Video Memory. I've spent many hours attempting to hunt this down to no avail. This bug is what causes all the distortion of the space invaders in the video, in-spite of it gameplay, collisions and stuff all appear to work fine.

Speed is around 1 frame/second with wire_expression2_unlimited 1, and 1frame/10seconds without. With the aforementioned optimisations along with resorting of the E2 code and general cleaning up this could easily see 30 frames/second with wire_expression2_unlimited 1 (with frameskip) half real-time. Not bad for E2 eh?

The 8080 Core is VERY similar to the Z80, to the point that the Z80 is backwards compatible with the 8080. The Gameboys cut-down Z80 is even more so similar to the 8080. I hope to use the lessons and experience I gained writing this in my in-development game boy emulator. I also intend to port this to GPU eventually.

Enough wall of text, pretty 1bit pictures and videos time.

https://www.youtube.com/watch?v=UwcfBp-5UeI

And the E2 code, no ROM included for obvious reasons, so it's really just for looking.
