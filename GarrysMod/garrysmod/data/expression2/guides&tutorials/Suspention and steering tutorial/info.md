- Author: postman ([TBU-TEC] THE P)
- Steam Profile: https://steamcommunity.com/profiles/76561197997916844
- Youtube: https://www.youtube.com/@blankrofl
<!-- -->
- Title: Suspention and steering tutorial
- Date (dd-mm-yyyy): 05-08-2012
- Source: https://web.archive.org/web/20130622143018/http://www.wiremod.com/forum/finished-contraptions/30340-suspention-steering-tutorial.html
- Source: https://www.youtube.com/watch?v=23WW61pHxGo
- Source Accessed (dd-mm-yyyy): 31-08-2025

## Suspention and steering tutorial

https://www.youtube.com/watch?v=23WW61pHxGo

**Steering code:**

```
@name 2 hydraulic steering
@inputs A D
@outputs Right Left



if(D)
{
    #A distance greater than that of the other left value,
    #toy around with it so that your car turns all the way, but not too much
    Left=90
}
else
{
    #The amount of distance the left hydro reads when your car's steering is straight
    Left = 41.63
}

if(A)
{
    #A distance greater than that of the other right value,
    #toy around with it so that your car turns all the way, but not too much
    Right=98
}
else
{
    #The amount of distance the right hydro reads when your car's steering is straight
    Right = 41.61
}
```

**Propulsion E2:**

```
@name Engine_Base
@inputs AdvPod:wirelink
@outputs RPM
@persist
@model models/mechanics/wheels/wheel_smooth_24f.mdl
runOnTick(1) #Run the chip however many times the tickrate is per second (default 66)
E=entity() #E is the proplusion wheel
RPM = abs(E:angVel():yaw()/360*60) #Get the RPM of the wheel

Active=AdvPod["Active",number]
Seat=AdvPod["Entity",entity]

if(first())
{
    soundPlay(1,0,"/vehicles/v8/v8_idle_loop0.wav") #Play a sound 
}

soundPitch(1,(1/5*round(RPM)+50)) #Set the pitch of the sound


if(Active){
    
    #wirelink
    W=AdvPod["W",number]
    S=AdvPod["S",number]
    Shift=AdvPod["Shift",number]
    Space=AdvPod["Space",number]
    
    if(!Space){
        E:applyAngForce( -ang(0,( (W-S) * (Shift ? 500000 : 150000) ),0)) #Make it go forward
    }


    if( (Space | !Active) ){
        E:applyTorque(-E:angVelVector()*E:mass()*5) #Brakes
    }
}
```

The above code is needed for the tutorial video listed above.
