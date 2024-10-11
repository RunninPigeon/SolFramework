/// @function scr_player_jump_start()
/// @self obj_player
function scr_player_jump_start()
{
	gml_pragma("forceinline");
	
	if (forced_roll || action == ACTION.SPINDASH || action == ACTION.DASH)
	{
		exit;
	}

	if (!input_press.action_any)
	{
		exit;
	}

	var _max_dist = 6;
	var _ceil_dist = _max_dist;
	var _x, _y;

	switch (tile_behaviour)
	{
		case TILEBEHAVIOUR.DEFAULT:	
			_y = y - radius_y;
			_ceil_dist = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];		
		break;

		case TILEBEHAVIOUR.ROTATE_90:
			_x = x - radius_y;
			_ceil_dist = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
		break;

		case TILEBEHAVIOUR.ROTATE_270:
			_x = x + radius_y;
			_ceil_dist = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
		break;
	}

	if (_ceil_dist < _max_dist)
	{
		exit;
	}

	if (animation != ANIM.SPIN)
	{
		y += radius_y - radius_y_spin;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
	}
	else if (global.roll_lock && global.player_physics != PHYSICS.CD)
	{
		air_lock_flag = true;
	}
	
	vel_x += jump_vel * dsin(angle);
	vel_y += jump_vel * dcos(angle);
	is_jumping = true;
	is_grounded = false;
	on_object = noone;
	set_push_anim_by = noone;
	stick_to_convex = false;
	animation = ANIM.SPIN;
	
	audio_play_sfx(snd_jump);
	return true;
}