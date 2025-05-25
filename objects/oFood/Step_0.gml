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
if fx == noone {
	fx = instance_create_layer(x, y, "Sprites", FoodSprite);
	fx.follow = id;
	fx.xOffset = 0;
	fx.yOffset = 0;
	fx.xscale_ratio = 0.5;
	fx.yscale_ratio = 0.5;
	fx.image_angle = choose(45,-45);
}