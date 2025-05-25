x = oPlayer.x;
y = oPlayer.y;
image_xscale = oPlayer.lastXDirection; // Flip for left/right
if oPlayer.gravityDir == -1 {
	image_yscale = -1;
	y -= 150;
} else {
	image_yscale = 1;}
	