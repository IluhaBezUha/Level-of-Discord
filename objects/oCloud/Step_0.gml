if place_meeting(x,y,oDisappear) or y == 1600 {
	instance_create_layer(0,4100,"Objects",oCloud,{image_xscale : 6})
	instance_destroy()
}

// Track delta
dx = x - lastX;
dy = y - lastY;

lastX = x;
lastY = y;
