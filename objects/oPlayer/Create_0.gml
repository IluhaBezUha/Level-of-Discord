currentX = 0;
currentY = 0;

entitySpeed = 12;
entityGravity = 0.2;

xMax = 3;
yMax = 16;

lastX = x;
lastY = y;

lastXDirection = 1;

jumping = false;
jumpingTimeout = 0;

onGround = place_meeting(x, y + 1, Ground);

if(!instance_exists(oPlayer_sprite)) {
	instance_create_layer(x, y, "Objects", oPlayer_sprite);
}
fallStartY = y;
isFalling = false;
