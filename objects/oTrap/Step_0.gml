if (!breaking && place_meeting(x, y - 1, oPlayer)) {
    breaking = true;
    shakeTimer = room_speed * 3; // 3 seconds
}

if (breaking) {
    shakeTimer--;

    // Shaking effect
    x = originalX + random_range(-20, 20);
    y = originalY + random_range(-10, 10);

    if (shakeTimer <= 0) {
        instance_destroy(); // breaks!
    }
}
