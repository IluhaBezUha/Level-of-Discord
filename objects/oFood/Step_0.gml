var tped = false
if (!tped && place_meeting(x, y, oPlayer)) {
    x += 15000
    tped = true;
    alarm[0] = room_speed * 10;
}
