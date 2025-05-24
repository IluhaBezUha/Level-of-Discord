// -- FALL SPEED TRACKING (TOP OF STEP EVENT) --
previousYSpeed = currentY;

// -- INPUT AND SURFACE CHECKS --
var input = global.horizontal;
onGround = place_meeting(x, y + gravityDir, Ground);
onIce = place_meeting(x, y + gravityDir, oIce);
if (onIce && !wasOnIce) {
    if (abs(currentX) < 4) {
        currentX += 4 * sign(input == 0 ? lastXDirection : input); // sudden nudge
    }
}
wasOnIce = onIce;

inSlowZone = place_meeting(x, y, oSlowZone); // for later use

// -- SPEED SETTINGS --
var maxSpeed = (global.run ? entitySpeed : entitySpeed / 2);
if onIce 
	maxSpeed = 1000

var accel = onIce ? 0.05 : entityAccel;
var fric = onIce ? 0.1 : entityfric;
var slowed = false
if (inSlowZone && !slowed) {
	slowed = true
	maxSpeed *= 0.5;
	accel *= 0.5;
	entityGravity *= 0.5
	jumpStrength *= 2
	yMax *= 0.5
}
if (!inSlowZone && slowed) {
	slowed = false
	maxSpeed *= 2;
	accel *= 2;
	entityGravity *= 2
	jumpStrength *= 0.5
	yMax *= 2
}
// -- HORIZONTAL MOVEMENT --
// Instead of setting currentX directly to input * accel, ease into it
// --- Ice Physics ---
if (onIce) {
    var sped = abs(currentX);
    var pdir = sign(currentX);

    // Slippery fast acceleration (scaled up!)
    var effectiveAccel = 0.8;
    var turnPenalty = clamp(sped * 0.4, 0, 3); // harder to turn when faster
    var inputAccel = input * effectiveAccel;

    // If trying to turn against momentum, apply penalty
    if (input != 0 && sign(input) != pdir && sped > 0.5) {
        inputAccel /= (1 + turnPenalty); // nerf the input when turning against motion
    }

    currentX += inputAccel;

    // Minimal friction — you'll coast forever unless braking
    if (input == 0 && abs(currentX) < fric) {
        currentX = 0;
    } else if (input == 0) {
        currentX -= sign(currentX) * fric;
    }
} else {
    if (input != 0) {
        currentX += input * accel;
    } else {
        if (abs(currentX) < fric) currentX = 0;
        else currentX -= sign(currentX) * fric;
    }
}

if (onIce && input != 0 && sign(currentX) != sign(input)) {
    currentX += input * (accel * 0.2); // penalize sudden turn
}




currentX = clamp(currentX, -maxSpeed, maxSpeed);

// -- DIRECTION TRACKING --
if (global.horizontal != 0) {
	lastXDirection = sign(global.horizontal);
}

// -- VERTICAL MOVEMENT: GRAVITY AND JUMPING --
if (onGround) {
	isFalling = false;
	jumpingTimeout = 10;

	if (global.jump) {
		currentY = -jumpStrength * gravityDir;
		jumping = true;
	}
	
} else {
	if (!isFalling && sign(currentY) == gravityDir) {
		isFalling = true;
		fallStartY = y;
	}
	
	if (global.jumpHold && jumpingTimeout > 0) {
		currentY = -jumpStrength * gravityDir;
		jumpingTimeout--;
	} else {
		currentY += entityGravity * gravityDir;
	}
}


// -- TRAMPOLINE INTERACTION --
if (place_meeting(x, y + 1, oTrampoline)) {
	var trampoline = instance_place(x, y + 1, oTrampoline);
	if (currentY > 0 && trampoline != noone) {
		var bounceStrength = clamp(abs(previousYSpeed) * 1.2, 4, 10000);
		currentY = -bounceStrength;

		if (variable_instance_exists(trampoline, "bounceX")) {
			currentX += trampoline.bounceX;
		}

		isFalling = false;
		jumping = false;
	}
}

currentY = clamp(currentY, -yMax, yMax);

// -- PLATFORM --
var plat = instance_place(x, y + 1, oPlatform);
if (plat != noone) && (!place_meeting(x+plat.dx,y,Ground)) && (!place_meeting(x,y+plat.dy,Ground)) {
    x += plat.dx;
    y += plat.dy;
}


// -- MOVEMENT (AFTER FORCES) --
if (!place_meeting(x + round(currentX), y, Ground)) {
	x += round(currentX);
} else {
	currentX = 0;
}

if (!place_meeting(x, y + round(currentY), Ground)) {
	y += round(currentY);
} else {
	currentY = 0;
}

// -- SPRITE ANIMATION --
if (!onGround) {
	if (jumping) {
		oPlayer_sprite.sprite_index = sPlayerJump;
	} else {
		//oPlayer_sprite.sprite_index = sPlayerFall; // enable if needed
	}
} else if (abs(currentX) > 0.5) {
	oPlayer_sprite.sprite_index = global.run ? sPlayerRun : sPlayerWalk;
} else {
	oPlayer_sprite.sprite_index = sPlayerIdle;
}

// -- ANIMATION FREEZE FOR JUMP --
if (oPlayer_sprite.sprite_index == sPlayerJump && oPlayer_sprite.image_index >= oPlayer_sprite.image_number - 1) {
	oPlayer_sprite.image_speed = 0;
} else {
	oPlayer_sprite.image_speed = 1;
}

if place_meeting(x,y,oDeath)
	room_restart()
	
	
	