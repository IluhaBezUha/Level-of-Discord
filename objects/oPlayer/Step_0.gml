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

if place_meeting(x,y,oSlowZone)
	slowMultiplier = 0.5;
else
	slowMultiplier = 1;
wasOnIce = onIce;

var insideZone = place_meeting(x, y, oSlowZone);

// ENTERING ZONE
if (insideZone && !inSlowZone) {
    inSlowZone = true;
    gravityFlippedInZone = true;
    gravityDir *= -1;
	gravityDir *= -1;

    // Apply low gravity and speed cap
    yMax = 1;
    entityGravity = 0.000001;
	currentY = 0;
}

// LEAVING ZONE
if (!insideZone && inSlowZone) {
    inSlowZone = false;
    gravityDir = originalGravityDir;
    gravityFlippedInZone = false;

    yMax = 10000;
    entityGravity = 0.5;
}

// FLIP gravity manually in zone
if (inSlowZone && keyboard_check_released(vk_up)) {
    gravityDir *= -1;
	currentY = clamp(currentY,-yMax,yMax)
}




// -- SPEED SETTINGS --
var maxSpeed = (global.run ? entitySpeed : entitySpeed / 2);
if onIce 
	maxSpeed = 1000

var accel = onIce ? 0.05 : entityAccel;
var fric = onIce ? 0.1 : entityfric;


// -- HORIZONTAL MOVEMENT --
// --- Ice Physics ---
if (onIce) {
    var sped = abs(currentX);
    var pdir = sign(currentX);


    var effectiveAccel = 0.8;
    var turnPenalty = clamp(sped * 0.4, 0, 3);
    var inputAccel = input * effectiveAccel;

   
    if (input != 0 && sign(input) != pdir && sped > 0.5) {
        inputAccel /= (1 + turnPenalty); 
    }

    currentX += inputAccel;


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
    currentX += input * (accel * 0.2);
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
		currentY = clamp(currentY,-yMax, yMax)
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
//currentX *= slowMultiplier
// -- PLATFORM --
var plat = instance_place(x, y + 1, oPlatform);
if (plat != noone) && (!place_meeting(x+plat.dx,y,Ground)) && (!place_meeting(x,y+plat.dy,Ground)) {
    x += plat.dx;
    y += plat.dy;
}


// -- MOVEMENT (AFTER FORCES) --
// -- HORIZONTAL MOVEMENT WITH CONTINUOUS STEP-UP SCAN --
// -- SMART STEP HANDLING (UP + DOWN) --
var signX = sign(currentX);
var absX = abs(round(currentX));
var maxStep = 17; 
var maxDrop = 4; 

for (var i = 0; i < absX; i++) {
	var moved = false;
	for (var j = 0; j <= maxStep; j++) {
		if (!place_meeting(x + signX, y - j * gravityDir, Ground) &&
		    !place_meeting(x + signX, y - j * gravityDir + gravityDir, Ground)) {
			x += signX;
			y -= j * gravityDir;
			moved = true;
			break;
		}
	}

	
	if (!moved) {
		if (!place_meeting(x + signX, y, Ground)) {
			x += signX;
		} 
		else {
			currentX = 0;
			break;
		}
	}
}




if (!place_meeting(x, y + round(currentY), Ground)) {
	y += round(currentY) * slowMultiplier;
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

//var tbelow = instance_place(x, y + 5, Ground);
//if (tbelow != noone) {
    //if (instance_exists(oPlayer_sprite)) {
   //     oPlayer_sprite.image_angle = -tbelow.image_angle;
	//	if tbelow.image_angle != 0 {
		//	oPlayer_sprite.y += 50
		//	
		//}
	//}
//}

if place_meeting(x,y,oDeath)
	game_restart()
	
