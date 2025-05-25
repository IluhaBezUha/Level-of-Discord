var plat = instance_place(x, y + 1, oPlatform);

if (plat != noone) {
    x += plat.dx;
    y += plat.dy;
}