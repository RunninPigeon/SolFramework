for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	var _speed = abs(_player.spd_ground);
		
	if (_player.on_object != id)
	{
		if (!_player.is_grounded || _speed < 6)
		{
			continue;
		}
		
		var _bound_inner = 192;
		var	_bound_outer = 208;
		
		if (_player.on_object != noone)
		{
			_bound_inner = 176;
			_bound_outer = 192;
		}
		else if (_player.state >= PLAYERSTATE.NO_CONTROL)
		{
			continue;
		}
		
		var _dist_x = floor(_player.x) - x;
		var _dist_y = floor(_player.y) - y - 16;
		
		if abs(_dist_y) >= 48
		{
			continue;
		}
		
		if (_player.vel_x < 0)
		{
			if (_dist_x < _bound_inner || _dist_x > _bound_outer)
			{
				continue;
			}
		}
		else if (_dist_x < -_bound_outer || _dist_x > -_bound_inner)
		{
			continue;
		}
			
		_player.spd_ground = _player.vel_x;
		_player.vel_y = 0;
		_player.angle = 0;
		_player.on_object = id;
		_player.action = ACTION.NONE;
			
		if (_player.animation != ANIM.SPIN)
		{
			_player.animation = ANIM.FLIP;
		}
	}
	else
	{
		var _dist_x = floor(_player.x) - x + 208;
		
		if (_dist_x < 0 || abs(_dist_x) >= 416 || !_player.is_grounded || _speed < 6)
		{
			with (_player)
			{
				on_object = noone;
			
				if (_player.animation != ANIM.FLIP)
				{
					break;
				}
				
				if (_speed < 6)
				{
					// Resume the animation from the current frame
					obj_set_order_frame(image_index);
				}
				else
				{
					animation = ANIM.MOVE;
				}
			}
		}
		else
		{
			with (_player)
			{
				if (animation != ANIM.FLIP)
				{
					break;
				}
				
				var _frame_index = floor(_dist_x / 8);
				
				if (facing == DIRECTION.NEGATIVE)
				{
					_frame_index = array_length(other.flip_frame_table) - _frame_index - 1;
				}
				
				image_index = other.flip_frame_table[_frame_index];
				
				// Stop the animation
				anim_timer = 0;
			}
		
			_player.y = y + offset_table[_dist_x] + _player.radius_y_normal - _player.radius_y;
		}
	}
}