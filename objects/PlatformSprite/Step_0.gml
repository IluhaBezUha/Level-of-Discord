if (instance_exists(follow)) {
    x = follow.x + xOffset;
    y = follow.y + yOffset;

    image_xscale = follow.image_xscale * xscale_ratio;
    image_yscale = follow.image_yscale * yscale_ratio;
} else {
    instance_destroy();
}
