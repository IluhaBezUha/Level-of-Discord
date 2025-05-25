if gravityDir == 1 {
	sprite_index = sCollisionMask;
} else {
	sprite_index = sCollisionMaskRev;
}

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


// -- PLATFORM --
var plat = instance_place(x, y + gravityDir, oPlatform);

if (plat != noone) {
    var pdx = plat.dx;
    var pdy = plat.dy * gravityDir;

    // Try full safe move first
    if (!place_meeting(x + pdx, y, Ground) && !place_meeting(x + pdx, y + pdy, Ground)) {
        x += pdx;
        y += pdy;
    }
    else {
        // Horizontal move check
        if (pdx != 0 && !place_meeting(x + pdx, y, Ground)) {
            x += pdx;
        } else if (pdx != 0) {
            // Push out of platform only if stuck
            while (place_meeting(x, y, plat)) {
                x += sign(pdx);
            }
        }

        // Vertical move check
        if (pdy != 0 && !place_meeting(x, y + pdy, Ground)) {
            y += pdy;
        } else if (pdy != 0) {
            while (place_meeting(x, y, plat)) {
                y += sign(pdy);
            }
        }
    }
}
