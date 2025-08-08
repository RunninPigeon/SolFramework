// Override draw
if (sprite_index < 0)
{
	return;
}

var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
	
if (offset_x[view_current] == undefined)
{
	offset_x[view_current] = x - _x;
	offset_y[view_current] = y - _y;
}

if (display_timer <= 12 || floor((display_timer - 13) / 8) % 2 == 1)
{
	draw_sprite(sprite_index, image_index, _x + offset_x[view_current], _y + offset_y[view_current]);
}