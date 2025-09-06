- Author: Paper Clip (glmcd) (glmcdona21) (glmcdona)
- Steam Profile: https://steamcommunity.com/profiles/76561197990877852
- Youtube: https://www.youtube.com/@glmcdona21
<!-- -->
- Title: Automatic, fastest possible, applyForce and applyAngForce code generating e2
- Date (dd-mm-yyyy): 03-02-2010
- Source: https://web.archive.org/web/20100210000758/http://www.wiremod.com/forum/contraptions-saves/17737-applyangforce-system-identification-dead-beat-controller-design-chip.html
- Source: https://www.youtube.com/v/Ja58hnd3slI
- Source: http://www.youtube.com/v/dftycqtjepI
- Source: http://www.youtube.com/v/8eaJpYEybpw
- Source Accessed (dd-mm-yyyy): 25-08-2025

## Automatic, fastest possible, applyForce and applyAngForce code generating e2

**What This Does**
Automatically generates the FASTEST POSSIBLE applyForce and appyAngForce code for a specific prop. It achieves this through some advanced control systems techniques as follows:

  - Generates a state-space model of the angle physics through a simple system identification technique.
  - Generates a dead-beat state feedback system for a specified interval, which works even when aiming straight up or down.
  - Prints simple E2 file to the console with the control system, for easy use in your contraption.
  - Outputs performance plots to e2files\positions.txt and e2files\angles.txt

**Instructions**
This works on either single props, or parented contraptions. To use this chip to design a perfect applyForce and applyAngForce , perform these steps:

  1. Spawn the prop to generate the apply force for.
  2. (optional) Edit the E2 options to pick the interval you desire. An interval of ~50 is good.
  3. Place the E2 chip on the prop.
  4. After a couple seconds, check your console for designed apply force chip. Copy and paste this code into a new e2.

**Video**
Filmed on McBuilds spacebuild servers.
New Version
https://www.youtube.com/v/Ja58hnd3slI

Old Version (applyAngForce only)
http://www.youtube.com/v/dftycqtjepI

Bonus Spacebuild carrier battle video!
http://www.youtube.com/v/8eaJpYEybpw

**Example Output Control Design**
When this expression is applied to a Pop Can, it outputs the following to the console. People who use apply force may be interested in the difference between the code which works for looking straight up and down versus not working for straight up and down. If anyone is interested, I can try to explain the fix in more details.

```
---SIMPLIFIED E2 CODE IMPLEMENTATION---
---(Does not work aiming straight up or down)---
@persist Prop:entity
if( first() | duped() ){
   Prop = entity():isWeldedTo(1)
   Prop:setMass(50000)
}
interval(50)
DesiredAngle = owner():eye():toAngle()
DifAngle = angnorm( Prop:angles() - DesiredAngle )
#DEADBEAT CONTROL: (FASTEST POSSIBLE)
Prop:applyAngForce(-ang(-16221632.593187*DifAngle:pitch() + 1477385.8142291*Prop:angVel():pitch(),13292629.967066*DifAngle:yaw() + 1135966.3028234*Prop:angVel():yaw(),-19832326.302666*DifAngle:roll() + 1462763.7101441*Prop:angVel():roll()))
---USE CONSOLE TO VIEW E2 CODE---
 
---ADVANCED E2 CODE IMPLEMENTATION---
---(Works aiming straight up and down)---
@persist Prop:entity
if( first() | duped() ){
   Prop = entity():isWeldedTo(1)
   Prop:setMass(50000)
}
interval(50)
# Perform the accurate angle calculation
DesiredDirection = owner():eye()
DesiredDirectionRight = owner():eye():cross(vec(0,0,1))
LocalDifference1 = vec(Prop:forward():dot(DesiredDirection),Prop:right():dot(DesiredDirection),Prop:up():dot(DesiredDirection))
LocalDifference2 = vec(Prop:forward():dot(DesiredDirectionRight),Prop:right():dot(DesiredDirectionRight),Prop:up():dot(DesiredDirectionRight))
DifAngle = angnorm(ang( LocalDifference1:toAngle():pitch(), LocalDifference1:toAngle():yaw(), LocalDifference2:toAngle():pitch() ))
 
# Apply for force
Prop:applyAngForce(-ang(-16221632.593187*DifAngle:pitch() + 1477385.8142291*Prop:angVel():pitch(),13292629.967066*DifAngle:yaw() + 1135966.3028234*Prop:angVel():yaw(),-19832326.302666*DifAngle:roll() + 1462763.7101441*Prop:angVel():roll()))
---USE CONSOLE TO VIEW E2 CODE---
```

**Example Spaceship Flight System**
The carrier flight system featured in the video used the designed applyAngForce as follows: (my parent prop was rotated in a weird way with respect to my ship forwards, so I had to make some changes)

```
@name Paper Carrier Flight System
@inputs Seat:entity W A S D
@outputs CamEnable CamPos:vector CamDir:vector
@persist Prop:entity
@trigger 

if( first() | duped() ){
   Prop = entity():isWeldedTo(1)
   Prop:setMass(50000)
}
interval(50)

if( Seat:driver() )
{
    ### ADDED cam-controller settings
    CamEnable = 1
    CamPos = Seat:pos() + 25*Seat:right() # View from 50 units forward, and 50 units up from the seat
    CamDir = Seat:right()*1000
    
    # Perform the accurate angle calculation
    EyeVector = vec(Seat:forward():dot(Seat:driver():eye()),-Seat:right():dot(Seat:driver():eye()),Seat:up():dot(Seat:driver():eye()))
    DesiredDirectionRight = EyeVector:cross(vec(0,0,1)) ####<--- Changed to:###
    DesiredDirection = EyeVector:cross(DesiredDirectionRight)
    
  
    LocalDifference1 = vec(Prop:forward():dot(DesiredDirection),Prop:right():dot(DesiredDirection),Prop:up():dot(DesiredDirection))
    LocalDifference2 = vec(Prop:forward():dot(DesiredDirectionRight),Prop:right():dot(DesiredDirectionRight),Prop:up():dot(DesiredDirectionRight))
    DifAngle = angnorm(ang( LocalDifference1:toAngle():pitch(), LocalDifference1:toAngle():yaw(), LocalDifference2:toAngle():pitch() ))
    
    # Apply angular force
    Prop:applyAngForce(-ang(-25294650.909335*DifAngle:pitch() + 1470277.0417309*Prop:angVel():pitch(),19412328.545875*DifAngle:yaw() + 1143146.4811801*Prop:angVel():yaw(),-24924383.24183*DifAngle:roll() + 1466070.9603029*Prop:angVel():roll()))
    
    # Apply positional force
    Force = (W-S)*90000000*Prop:up() + (D-A)*90000000*Prop:right() - 50000*Prop:vel()
    Prop:applyForce(Force)
}else{
    CamEnable = 0
    
    # Cancel all angular velocity
    DifAngle = ang(0,0,0)
    Prop:applyAngForce(-ang(-25294650.909335*DifAngle:pitch() + 1470277.0417309*Prop:angVel():pitch(),19412328.545875*DifAngle:yaw() + 1143146.4811801*Prop:angVel():yaw(),-24924383.24183*DifAngle:roll() + 1466070.9603029*Prop:angVel():roll()))
    Force = -50000*Prop:vel()
    Prop:applyForce(Force)
}
```

**How it Works**
This expression is based on some more complex state-space control system theories, but I will try and provide the general idea of how it works. If these topics really interest you, I encourage you to study electrical or mechanical engineering control system theory.

1. System Identification
    When applying angular force to a prop, all props act differently. This behaviour is related to the objects mass, size in each direction, and welded/parented props. This behaviour can be represented as a [state space system](https://web.archive.org/web/20100210000758/http://en.wikipedia.org/wiki/State_space_(controls)). It is assumed that we have a second order state space system for each angular direction such as:

    Pitch [Next Time Interval] = SomeFactor*Pitch [Last Interval] + SomeFactor*Velocity[Last Interval] + SomeFactor*applyAngForce[Last Interval]
    Pitch Velocity[Next Time Interval] = SomeFactor*Velocity[Last Interval] + SomeFactor*applyAngForce[Last Interval]

    Through applying some force, and measuring the pitch and angular velocity, these factors are determined for the prop based on some simple derivations I constructed.

2. Dead-beat Control Design
    Once a discrete-time state space model has been identified for the prop, we can derive an optimal applyAngForce which will set the angle to be exactly where we want it in 1 time interval. This optimal applyAngForce is called a [Dead-beat controller](https://web.archive.org/web/20100210000758/http://en.wikipedia.org/wiki/Dead_beat_control). To achieve this deadbeat controller, all three poles of the state-space model are placed at the origin through an eigenvalue placement method using state-feedback. For more information regarding this, refer to [continuous-time state feedback](https://web.archive.org/web/20100210000758/http://en.wikipedia.org/wiki/Full_state_feedback) for details (though in this case it is discrete time).

**Performance Plots on Parented Carrier**
The chip outputs the performance of the error of the angle and position versus time to the files data/e2files/positions.txt and angles.txt

When applied to my carrier ship as seen in the video, it generated the following performance data: (running at interval 50, each point represents one tick)

It can be seen that the position is taking between 1 and 2 server ticks to converge, while the angle controller takes around 4 ticks to converge mostly. These deviations from the dead-beat controller design of 1 tick to converge are as a result of the carrier not being completely parented, causing non-linearities not accounted for in the system identification.
