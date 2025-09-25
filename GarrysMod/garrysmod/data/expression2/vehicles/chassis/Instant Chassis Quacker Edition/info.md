# Expression 2 - E2 Instant Chassis Quacker Edition

## Details

### Author

- Author: [NQMB] Noorquacker
- Steam Profile: https://steamcommunity.com/profiles/76561198116712825
- Github: https://github.com/Noorquacker

### Original Author

- Author: Cipher_Ultra
- YouTube: https://www.youtube.com/user/CipherUltra
- Steam Profile: https://steamcommunity.com/profiles/76561197978513282

### Publication Info

- Title: E2 Instant Chassis Quacker Edition
- Date (mm-yyyy): 07-03-2015
- Source: https://web.archive.org/web/20150426235602/http://www.wiremod.com/forum/finished-contraptions/34157-e2-instant-chassis-quacker-edition-post286368.html
- Source Accessed (dd-mm-yyyy): 22-08-2025

### Original Publication Info

- Title: [E2] Instant Chassis - Steering and Suspension
- Date (mm-yyyy): 21-01-2011
- Source: https://web.archive.org/web/20150716034205/http://www.wiremod.com:80/forum/finished-contraptions/28138-e2-instant-chassis-v2.html
- Source: https://web.archive.org/web/20160504052312/http://www.wiremod.com:80/forum/finished-contraptions/24483-e2-instant-chassis-steering-suspension.html
- Source: Meta Construct, advanced duplicator 1: public folder
- Source Accessed (dd-mm-yyyy): 22-08-2025

## E2 Instant Chassis Quacker Edition

Yes, there's an Instant Chassis and a V2, but I got ahold of the 2011 edition of this a long time ago before I knew about this and often used it. I've made some heavy updating, including:

```plaintext
EGP HUD showing MPH and Throttle(1080p monitors only)
Pressing Shift for Speed Boost
Pressing Alt to revert to angles 0,0,0(very buggy!)
Using SECRET input to kill your car and set throttle to 1400
Using Suspension input to make your car hover. Min: 28.2
Lights, if you have the E2 plugin adding lightCreate()
Pressing R to freeze the car
Output variable for F, preferred to use for resetting Suspension input
Output variable for Mouse1, can be used for cars with guns
Making the suspension hit water and don't go underwater
Making the suspension not hit water if it goes underwater
Making the car work underwater
New engine sound, now it isn't so annoying at 1400 throttle
Disabling the car itself for transportation and elevators. Change the code first!
```

I think I got them all, and I'll continue updating it a lot. Currently it's software version 5.1. You guys can post bugs and for you other coders, there's an entire new section called Noorquacker's Coding for editing and changing all of the stuff in there. You don't wanna mess with some important stuff, though.  
And here's an additional note:

- I can't change the EGP HUD for 720p or lower settings. Why? It took me a long time to make the HUD, and doing the 0 to 512 EGP HUD variable streches everything to your monitor ratio. Even if I could make the circles not strechy, the pointer wouldn't work because it's using sine and cosine.
Here's the entire code!

You also should change a lot of stuff for your own usage.
