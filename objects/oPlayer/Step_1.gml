// Track highest Y to measure fall distance
if (onGround) {
    fallStartY = y;
}

if (!onGround && y < fallStartY) {
    fallStartY = y; // keep updating if we're still rising
}

lastX = x;
lastY = y;