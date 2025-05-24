var tped = false
if (!tped && place_meeting(x, y, oPlayer)) {
	if a != true {
		x += 15000;
		tped = true;
		alarm[0] = room_speed * 10;
	}
	else {
		instance_destroy();
	}
	oPlayer.jumpStrength += 4;
	oPlayer.entitySpeed += 4;
}
