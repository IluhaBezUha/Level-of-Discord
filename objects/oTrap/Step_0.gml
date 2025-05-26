if (!breaking && place_meeting(x, y - 1, oPlayer)) {
    breaking = true;
    shakeTimer = room_speed * 1.5;
}

if (breaking) {
    shakeTimer--;


    x = originalX + random_range(-20, 20);
    y = originalY + random_range(-10, 10);

    if (shakeTimer <= 0) {
        instance_destroy();
    }
}
if fx == noone {
	fx = instance_create_layer(x, y, "Sprites", TrapSprite);
	fx.follow = id;
	fx.xOffset = 0;
	fx.yOffset = 0;
	fx.xscale_ratio = 0.34;
	fx.yscale_ratio = 0.34;
}