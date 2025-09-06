# Expression 2 - [RELEASE] E2 Armor Analyzer

## Details

### Author

- Author: Red Reaper (RedReaper) (redreaper2020)
- Youtube: https://www.youtube.com/@redreaper-xe6so

### Publication Info

- Title: [RELEASE] E2 Armor Analyzer
- Date (dd-mm-yyyy): 06-03-2015
- Source: https://web.archive.org/web/20150426235117/https://wiremod.com/forum/finished-contraptions/34146-e2-general-purpose-armor-analyzer.html
- Source: https://www.youtube.com/watch?v=AYWlaeelFfg
- Source Accessed (dd-mm-yyyy): 05-09-2025

## Description

This is a layered armor scanner, for ballistics checking. This project came about as a combination of seeing a very similar (almost identical) tool demonstrated by fervidusletum, and a need by myself to develop many of the rendering functions, for a completely unrelated project.

https://www.youtube.com/watch?v=AYWlaeelFfg

This E2 saves a lot of time and headache. It allows you to quickly scan something for weakness, ricochet tendencies, and vulnerabilities. It is useful for self-diagnostic; it only works on either your own things, or those which you have prop permissions on.

It will output an image onto a digital screen in the set resolution, colored for clarity. Here is an example:  
see 4000_screenshots_2015-03-06_00021.jpg

The green areas are highly resistant--they manage to stop a round of the input penetration.  
Any orangishness or reddishness means it would not stop the round of the input penetration.  
Any bluishness or tealishness indicates that the round would have hit a vulnerable spot--ammo, engines, transmissions, pods, etc.  
The light (in overall brightness) areas are areas that a HE/HEAT shell would probably explode upon. Dark areas indicate where a round would have a high chance of ricochet. In this example, around the front glacis there is a high chance of ricochet--the trace was taken side-on, with a very slight angling.

Instructions for use and the additional features (which are somewhat beta-quality) are included in the E2. It only requires a digital screen for operation. If I make improvements, I will upload them here as time allows. Please leave C&C below.

For other coders: the code in this is actually human-readable (lol) and fairly documented with as much use of modular functionality as possible, so you can reuse chunks (like I do) for your own projects. It's also set up so that "mode" can be altered--I've not tested it but it should be able to support other rendering purposes. Specifically it's currently set to render off a single very long array, meaning it'll cap at a size of 1024x1024--I think wire screen caps at 512x512 anyway.
