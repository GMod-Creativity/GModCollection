- Author: Drunkie
<!-- -->
- Title: Re: Official WIP Thread - What are you working on?
- Date (dd-mm-yyyy): 01-02-2012
- Source: https://web.archive.org/web/20121113114618/http://www.wiremod.com/forum/finished-contraptions/28120-official-wip-thread-what-you-working-2.html
- Source: https://pastebin.com/BbtDg9y5
- Source Accessed (dd-mm-yyyy): 23-08-2025

## Procedural Terrain Generator

Working on a procedural terrain generator in GPU.

Details:

Written in C with the GL driver.
Rendered in the sprite buffer by iteratively drawing one quad at a time. #nolag
It uses the index buffer (new feature of the GPU).
Really fast!

(Update your SVN to get the updated graphics library: drv_gl.txt)
