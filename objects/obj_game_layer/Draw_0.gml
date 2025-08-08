var _camera_x = camera_get_x(view_current);
var _camera_y = camera_get_y(view_current);
var _camera_w = camera_get_width(view_current);
var _camera_h = camera_get_height(view_current);

var _height = sprite_get_height(sprite_index);
var _texture = sprite_get_texture(sprite_index, image_index);

var _x = floor((_camera_x - obj_game.bg_distance_x) * (1 - factor_x) + obj_game.bg_scroll_x * scroll_mult_x) + offset_x;
var _y = floor((_camera_y - obj_game.bg_distance_y) * (1 - factor_y) + obj_game.bg_scroll_y * scroll_mult_y) + offset_y;
var _scale = 1.0;

if (anim_duration > 0)
{
    image_index = floor(frame_counter / anim_duration) % sprite_get_number(sprite_index);
}

if (scale_target_y != -1)
{
	// Calculate recommended factor_y
	if (factor_y == 0)
	{
		show_debug_message(sprite_get_name(sprite_index) + string_format((offset_y - _camera_h * 0.5) / (scale_target_y_init - _camera_h * 0.5), 10, 9));
	}
	
	_scale = clamp((scale_target_y - _y) / _height, -1, 1);
}

var _do_line_scroll = line_height >= 0;
if (_do_line_scroll)
{
	shader_line_scroll(_camera_x, _x, _y, _height, _scale, _texture, line_factor_x - factor_x, line_height);
}

if (vtiled)
{
	draw_sprite_tiled_ext(sprite_index, image_index, _x, _y, 1.0, _scale, c_white, 1.0);
}
else if (htiled)
{
	draw_sprite_tiled_h_ext(sprite_index, image_index, _x, _y, 1.0, _scale, c_white, 1.0, -CAMERA_HORIZONTAL_BUFFER, _camera_x + _camera_w);
}
else
{
	draw_sprite_ext(sprite_index, image_index, _x, _y, 1.0, _scale, 0.0, c_white, 1.0);
}

if (_do_line_scroll)
{
	shader_reset();
}