# Expression 2 - ballistics_4/Fire control 1

## Details

### Author

- Author: Tolyzor
- Steam Profile: https://steamcommunity.com/profiles/76561197980070446
- YouTube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor

### Publication Info

- Title: Re: ACF Bulletometer 2
- Date (dd-mm-yyyy): 01-06-2013
- Source: https://web.archive.org/web/20150304052657/http://www.wiremod.com/forum/finished-contraptions/31833-acf-bulletometer-2-a.html
- Source Accessed (dd-mm-yyyy): 24-08-2025

## Description

### Re: ACF Bulletometer 2

Cool. Why only predict the hit position, when instead you can predict the required launch angle to hit a target?

My vanilla gmod solution here uses RKF45 + a newton-raphson iterative solver, and is very quick. You tell it where the target is and the required accuracy, and it tells you what angle to shoot at. It also outputs the firing solution trajectory, which you can plot using holos of course. I'm sure you can convert it to ACF

**Comment Splambob:**  
That looks very interesting, I'll be sure to read through it! It only finds the hitpos to keep the chip fast, runnable at up to 20hz (conservatively) before it ticks-out. Could make an ACF artillery chip based on your work if I clear the time.
