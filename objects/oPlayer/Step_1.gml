previousYSpeed = currentY;

if (!onGround && !isFalling && sign(currentY) == gravityDir) {
	isFalling = true;
	fallStartY = y;
}

if (onGround && !place_meeting(x, y + 1, oTrampoline)) {
	fallStartY = y;
	isFalling = false;
}

if (!onGround && y < fallStartY) {
	fallStartY = y;
}
