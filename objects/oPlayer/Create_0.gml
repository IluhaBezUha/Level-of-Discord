currentX = 0;
currentY = 0;

xMax = 4;
yMax = 10000;

entitySpeed = 10;
entityAccel = 0.6;
entityfric = 0.2;
entityGravity = 0.5;
gravityDir = 1; // 1 = down, -1 = up

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