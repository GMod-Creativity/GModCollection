Author: Dakota

*New Mech Chip*

Hello, this is my first post here, but I've been around on Gmod for a few years now as a builder. I've taken the past 3 days to create a new mech chip after previous public ones I've used were not cutting it for me.

This mech chip runs lower ops than most (~700 ops, ~250 cpu us) and can create very stable mechs given correct settings. Included in the mech chip are instructions on how to use it, how to create a mech, and other tips, along with the link to another e2 I made to play the sounds for the mech.

This mech chip is for bipedal walkers only, in the future I may release a version for more feet, but I have no current plans to, this chip can be considered finished.

Contact information is also provided in the chip.

Pastebin Link:
Dakmek 2016

I would like to hear any feedback you have.

Special thanks to Sestze for his suggestion and instruction on hip bobbing forces.

EDIT:
I've edited a few things, thanks to my friend Oh Please, his scrutiny is unmatched. He also told me about the code tags.

EDIT2:
I've fixed an issue with sounds triggering too often and added in ambient engine sounds and modifiers.

EDIT3:
Fixed an issue with non standard angle offsets.

EDIT4:
Fixed sound pitch issue.

EDIT5:
Fixed an issue with sound triggers.

EDIT6:
Added torso chip link and code to post.

Code:
@name Mech Torso stuff
@inputs Torso:entity Pod:wirelink Cam:wirelink Ded
@outputs
@persist AngleOffset:angle RotationSpeed Elevation Depression FlipPitch FlipRoll SwapRollAndPitch
@trigger 
interval(1)

#NOTES
#Make this E2 point forward
#This should be welded to the HIP
#The e2 finds the angle of the torso when you refresh it
#Only refresh the e2 when you have the torso angle where you want it
#Make sure to refresh the e2 after spawning it
#Wire Ded to the Ded output on the DakMek 2016 chip

if(first()|dupefinished()){
AngleOffset=entity():toLocal(Torso:angles())

############
#EDIT START#
############

RotationSpeed = 15 #Speed of Rotation
Elevation = 25 #max Pitch
Depression = 25 #min Pitch
FlipPitch = 0
SwapRollAndPitch = 1
FlipRoll = 0

###########
#EDIT STOP#
###########
}

Active = Pod["Active",number]


if(Ded==0){
    if(Active==1){
        CA = Cam["CamAng", angle]
        if(FlipPitch){Pitch = -CA:pitch()}else{Pitch = CA:pitch()}
        if(FlipRoll){Roll = -CA:roll()}else{Roll = CA:roll()}
        if(SwapRollAndPitch){CAMANG = ang(Roll,CA:yaw(),Pitch)}else{CAMANG = ang(Pitch,CA:yaw(),Roll)}
        TorsoPos = Torso:pos()
        TorsoAng = Torso:toLocal(CAMANG+AngleOffset)*ang(1,1,1)
        ANGLE = clamp(TorsoAng,ang(-RotationSpeed),ang(RotationSpeed))
        YAW = abs(TorsoAng:yaw())
        if(YAW >45){ANGLE = clamp(ANGLE,ang(-180,-180,-180),ang(180,180,180))*ang(1,1,1)
        }else{ANGLE = clamp(TorsoAng,ang(-RotationSpeed),ang(RotationSpeed))}
        if(SwapRollAndPitch){CLAMPANG = clamp(Torso:toWorld(ANGLE),ang(0 ,-180,-min(Elevation,abs(CAMANG:roll()))),ang(0,180,min(Depression,abs(CAMANG:roll()))))}
        else{CLAMPANG = clamp(Torso:toWorld(ANGLE),ang(-min(Elevation,abs(CAMANG:pitch())) ,-180,0),ang(min(Depression,abs(CAMANG:pitch())),180,0))}
        Torso:applyAngForce((Torso:toLocal(CLAMPANG) * 250 - Torso:angVel() * 30) * shiftL(ang(Torso:inertia())))
    }
    
    if(Active==0){
        CAMANG = entity():angles()
        TorsoPos = Torso:pos()
        TorsoAng = Torso:toLocal(CAMANG+AngleOffset)*ang(1,1,1)
        ANGLE = clamp(TorsoAng,ang(-RotationSpeed),ang(RotationSpeed))
        YAW = abs(TorsoAng:yaw())
        if(YAW >45){ANGLE = clamp(ANGLE,ang(-180,-180,0),ang(180,180,0))*ang(1,1,1)
        }else{ANGLE = clamp(TorsoAng,ang(-RotationSpeed),ang(RotationSpeed))}
        CLAMPANG = clamp(Torso:toWorld(ANGLE),ang(-min(Elevation,abs(CAMANG:pitch())) ,-180,0),ang(min(Depression,abs(CAMANG:pitch())),180,0))    
        Torso:applyAngForce((Torso:toLocal(CLAMPANG) * 250 - Torso:angVel() * 30) * shiftL(ang(Torso:inertia())))
    }
}
Mech Torso Stuff

EDIT 7:
Released an update for the torso chip for a variable to swap the roll and pitch in cases in which it is needed.

EDIT 8:
Minor logic fix for jetpack

EDIT 9:
Fixed hill climbing issues and getting stuck when falling off hills.

EDIT 10:
Improved stability when standing still and crouching. Also slightly reduced op count.

EDIT 11:
Updated Torso chip stability.

EDIT 12:
Included gun control chip.

Code:
@name Mech Gun stuff
@inputs Gun:entity Pod:wirelink Cam:wirelink
@outputs ANG2:angle Test GunAng:angle
@persist AngleOffset:angle RotationSpeed Elevation Depression YawMin YawMax
@trigger 
interval(100)

#Place this chip on the prop that the gun is ballsocketed to
#Make sure the arrow is pointing forward on the chip.

if(first()|dupefinished()){
AngleOffset=ang(0,0,0) #edit the third value here to change the gun's rotation, 180 will flip it over.
RotationSpeed = 25
Elevation = 15
Depression = 15
YawMin = 15
YawMax = 15
}


Active = Pod["Active",number]
    
if(Active==1){
    CAM1 = Cam["CamPos", vector]
    CAM2 = Cam["HitPos", vector]
    CAMANG = Cam["CamAng", angle]
    GunPos = Gun:massCenter()
    GunAng = (rangerOffset(9999999999,CAM2,CAMANG:forward()):pos() - GunPos):toAngle() 
    ANGLE = clamp(Gun:toLocal(GunAng),ang(-RotationSpeed),ang(RotationSpeed))
    CLAMPANG = clamp(entity():toLocal(Gun:toWorld(ANGLE)),ang(-min(Elevation,abs(CAMANG:pitch())) ,-YawMin,0),ang(min(Depression,abs(CAMANG:pitch())),YawMax,0))
    Gun:applyAngForce((Gun:toLocal(entity():toWorld(CLAMPANG+ AngleOffset)) * 250 - Gun:angVel() * 30) * shiftL(ang(Gun:inertia())))
}

if(Active==0){
    ANG=entity():toWorld(ang(0,0,0)+AngleOffset)
    Q=quat(ANG)/quat(Gun)
    Torque=Gun:toLocal(rotationVector(Q) + Gun:pos())
    Torque=((Torque*250) -Gun:angVelVector()* 50)*Gun:inertia()
    Gun:applyTorque(Torque)
    Gun:applyTorque(-Gun:angVelVector()*pi()/180*Gun:inertia()*1550.1*1/2)
}
Mech Gun Stuff

EDIT 13:
Added variables for the torso chip to allow flipping of various angles.

EDIT 14:
Updated torso chip to fix and issue with swapped rolls and pitches

EDIT 15:
Worked on optimizing code (cut about 100 ops) and changed stock step sound.

EDIT 16:
Fixed an issue with the mech sliding when stationary.

EDIT 17:
Fixed an issue with feet being very far infront of or behind the hip causing issues with the speed of the mech, also added in more info in the constraint tips.