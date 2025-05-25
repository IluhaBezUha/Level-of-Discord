currentX = 0;
currentY = 0;

xMax = 4;
yMax = 10000;

entitySpeed = 14;
entityAccel = 0.5;
entityfric = 0.2;
entityGravity = 0.5;
gravityDir = 1; // 1 = down, -1 = up
originalGravityDir = gravityDir;
gravityFlippedInZone = false; 


jumpStrength = 16;
jumpingTimeout = 10;
isFalling = false;
fallStartY = y;
jumping = false;

onGround = false;
onIce = false;
inSlowZone = false;
lastXDirection = 1;
bounceX = 0;
previousYSpeed = 0;
wasOnIce = onIce;
slowMultiplier = 1;
wasInSlowZone = false;
inSlowZone = false;
beingPulled = false;
slowPulled = false;
slowZoneInstance = noone;
slowX = 0;
slowY = 0;
pulledOnce = false
inSlowZone = false;
slowState = 0; // 0 = normal, 1 = pulling
slowZone = noone;
