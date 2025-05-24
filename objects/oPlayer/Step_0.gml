

currentX += global.horizontal * entitySpeed;
currentY += 0.3;

if(global.horizontal == 0) {
	if(currentX > 0 && currentX >= entitySpeed) {
		currentX -= entitySpeed;
	} else if(currentX > 0 && currentX < entitySpeed) {
		currentX = 0;
	}
	
	if(currentX < 0 && currentX <= -entitySpeed) {
		currentX += entitySpeed*2;
	} else if(currentX < 0 && currentX > -entitySpeed) {
		currentX = 0;
	}
} 
if(onGround)
	xMax = global.run ? entitySpeed : entitySpeed / 2;


currentX = clamp(currentX, -xMax, xMax);
currentY = clamp(currentY, -yMax, yMax);

onGround = place_meeting(x, y + 1, Ground);

if(global.horizontal != 0)
	lastXDirection = global.horizontal;

oPlayer_sprite.image_speed = 1;
oPlayer_sprite.image_xscale = lastXDirection;

if (onGround) {
    isFalling = false;
} else {
    if (!isFalling && currentY > 0) {
        isFalling = true;
        fallStartY = y; // store the point where fall *starts*, only once
    }
}

if(!place_meeting(x, y - abs(round(currentX)), Ground) && onGround) {
	while(place_meeting(x + round(currentX), y, Ground) && !place_meeting(x + round(currentX), y - abs(round(currentX)), Ground)) {
		y -= 1;
	}
}

var moved = false;
for (var i = 0; i <= 7; i++) { // Try to move up to 4 pixels up
    if (!place_meeting(x + round(currentX), y - i, Ground)) {
        x += round(currentX);
        y -= i;
        moved = true;
        break;
    }
}
if (!moved) {
    currentX = 0; // Cancel movement if blocked
}


if(place_meeting(x, y + abs(round(currentX)) + 1, Ground) && onGround) {
	while(!place_meeting(x, y + 1, Ground)) {
		y += 1;
	}
}

if(!onGround && !global.jumpHold || !onGround && jumpingTimeout == 0)
	currentY += entityGravity;

if(!onGround && global.jumpHold && jumpingTimeout > 0) {
	currentY = -24;
	jumpingTimeout--;
}

if(!place_meeting(x, y + round(currentY), Ground)) {
	y += round(currentY);
} else {
	while(!place_meeting(x, y + sign(currentY), Ground)) {
		y += sign(currentY);
	}
	
	currentY = 0;
}

if(!jumping && currentY < 0 && !onGround) {
	jumping = true;
	oPlayer_sprite.image_index = 0;
} else if(jumping && oPlayer_sprite.image_index >= oPlayer_sprite.image_number - 1) {
	jumping = false;
	oPlayer_sprite.image_index = 0;
}

if place_meeting(x,y,oDeath)
	room_restart()
	
if(onGround) {
	jumpingTimeout = 10;
	
	if(lastX != x && global.horizontal != 0) {
		oPlayer_sprite.sprite_index = global.run ? sPlayerRun : sPlayerWalk;
	} else {
		oPlayer_sprite.sprite_index = sPlayerIdle;
	}
} else {
	if(jumping)
		oPlayer_sprite.sprite_index = sPlayerJump;
	//else
	//	oPlayer_sprite.sprite_index = spr_player_falling;
}

if(!onGround && !global.jumpHold)
	jumpingTimeout = 0;

if (place_meeting(x, y + 1, oPlatform)) {
	var plat = instance_place(x, y + 1, oPlatform);
	if (plat != noone) {
		x += plat.dx;
		y += plat.dy;
	}
}


if(onGround && global.jump) {
	currentY = -12;
	oPlayer_sprite.image_index = 0;
}

if(oPlayer_sprite.sprite_index == sPlayerJump &&  oPlayer_sprite.image_index >= oPlayer_sprite.image_number - 1) {
	   oPlayer_sprite.image_speed = 0;
}

/* Enable this if you don't want the falling animation to loop

if(obj_player_sprite.sprite_index == spr_player_falling &&  obj_player_sprite.image_index >= obj_player_sprite.image_number - 1) {
	   obj_player_sprite.image_speed = 0;
}*/
if (place_meeting(x, y + 1, oTrampoline)) {
    var trampoline = instance_place(x, y + 1, oTrampoline);
    
    if (currentY > 0 && trampoline != noone) {
        // Use velocity directly for bounce strength
        var bounceStrength = clamp(abs(currentY) * 1.2, 6, 160);
        currentY = -bounceStrength;

        isFalling = false;
        fallStartY = y; // reset fall start to avoid chaining problems

        // Optional: play animation or sound
    }
}
