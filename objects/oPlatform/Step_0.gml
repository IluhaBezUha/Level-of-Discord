if dir == 0
	move_towards_point(endX, endY, pspd)
	if distance_to_point(endX, endY) < pspd
		dir = 1
else if dir == 1
	move_towards_point(startX, startY, pspd)
	if distance_to_point(startX, startY) < pspd
		dir = 0
		
dx = x - lastX;
dy = y - lastY;

lastX = x;
lastY = y;