Place dupe file in C:\Program Files (x86)\Steam\steamapps\user_name\garrysmod\garrysmod\data\adv_duplicator.



--------------------How to use-----------------------

1. Spawn AUTODYNO and the engine you want to test with their axis paralell

2. Adv Ballsocket the crankshaft of your engine to the rotor of the AUTODYNO 
(all max settings at -180, min settings at 180, free movement checked)

3. unfreeze the AUTODYNO rotor 

4. Start your engine and press the test button on the AUTODYNO Screen 

5. Come back a few minutes later to view the results


Note:

1. The screen is a touch screen. press "use" to use it. 

2. You can chanage the display units by pressing their respective tab during or after a test.

3. You can change the contrast by pressing on the main screen.

4. You can change the number of data points tested by editing the constant value named "test increments"

5. Any warnings or errors that the AUTODYNO reports will be duplicated in a report printed to console
when the test finishes. You can generaly ignore them unless the Autodyno refuses to complete the test.

6. RSD stands for relative standard deviation and is a measure of engine roughness (lower is smoother and better)


See the video demonstration: http://www.youtube.com/watch?v=b1JRxzCrFwA



To understand what each display value means in further detail, I suggest looking on wikipedia.



by Tolyzor - contact at the wiremod.com forums.

Thanks to the users to Spaceindavers, Nodex and Unsmarts servers for providing me with engines to test!



##############################################################################################################
R1.1 fixes

1. Drag compensation for non standard air densities now works
2. Very high acceleration engine crankshaft MoI is now reported as negligible rather than -1.#IND
4. Text position and size updated for egp bold text revert