/// @function scr_player_collision_air
function scr_player_collision_air()
{
	gml_pragma("forceinline");
	
	if (action == ACTION.GLIDE || action == ACTION.CLIMB)
	{
		return;
	}

	var _move_quad = math_get_quadrant(math_get_vector_rounded(vel_x, vel_y));
	var _wall_radius = radius_x_normal + 1;
	
	if (_move_quad != QUADRANT.RIGHT)
	{
		var _wall_dist = tile_find_h(x - _wall_radius, y, DIRECTION.NEGATIVE, tile_layer)[0];
		
		if (_wall_dist < 0)
		{
			x -= _wall_dist;
			vel_x = 0;
			
			if (_move_quad == QUADRANT.LEFT)
			{
				spd_ground = vel_y;
				return;
			}
		}
	}
	
	if (_move_quad != QUADRANT.LEFT)
	{
		var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];
		
		if (_wall_dist < 0)
		{
			x += _wall_dist;
			vel_x = 0;
		
			if (_move_quad == QUADRANT.RIGHT)
			{
				spd_ground = vel_y;
				return;
			}
		}
	}
	
	if (_move_quad != QUADRANT.DOWN)
	{
		var _y = y - radius_y;
		var _roof_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.NEGATIVE, tile_layer);
		var _roof_dist = _roof_data[0];
		var _roof_angle = _roof_data[1];
	
		if (_roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS.S3)
		{	
			var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];
			
			if (_wall_dist < 0)
			{
				x += _wall_dist;
				vel_x = 0;
				
				return;
			}
		}
		else if (_roof_dist < 0)
		{
			y -= _roof_dist;
			
			var _roof_quad = math_get_quadrant(_roof_angle);
			
			if (_move_quad == QUADRANT.UP && (_roof_quad == QUADRANT.LEFT || _roof_quad == QUADRANT.RIGHT) && action != ACTION.FLIGHT)
			{
				angle = _roof_angle;
				spd_ground = _roof_angle < 180 ? -vel_y : vel_y;
				vel_y = 0;
				
				land();
				return;
			}
		
			if (vel_y < 0)
			{
				vel_y = 0;
			}
		
			if (action == ACTION.FLIGHT)
			{
				grv = PARAM_GRV_TAILS_DOWN;
			}
			
			return;
		}
	}
	
	if (_move_quad != QUADRANT.UP)
	{
		var _floor_dist;
		var _floor_angle;
		var _y = y + radius_y;
	
		if (_move_quad == QUADRANT.DOWN)
		{
			var _floor_data_l = tile_find_v(x - radius_x, _y, DIRECTION.POSITIVE, tile_layer);
			var _floor_data_r = tile_find_v(x + radius_x, _y, DIRECTION.POSITIVE, tile_layer);
		
			if (_floor_data_l[0] > _floor_data_r[0])
			{
				_floor_dist = _floor_data_r[0];
				_floor_angle = _floor_data_r[1];
			}
			else
			{
				_floor_dist = _floor_data_l[0];
				_floor_angle = _floor_data_l[1];
			}
		
			var _min_clip = -(vel_y + 8);
			
			if (_floor_dist >= 0 || _floor_data_l[0] < _min_clip && _floor_data_r[0] < _min_clip)
			{
				return;
			}
		
			if (math_get_quadrant(_floor_angle) != QUADRANT.DOWN)
			{
				if (vel_y > 15.75)
				{
					vel_y = 15.75;
				}
				
				spd_ground = _floor_angle < 180 ? -vel_y : vel_y;
				vel_x = 0;
			}
			else if (_floor_angle > 22.5 && _floor_angle <= 337.5)
			{
				spd_ground = _floor_angle < 180 ? -vel_y : vel_y;
				spd_ground *= 0.5;
			}
			else 
			{
				spd_ground = vel_x;
				vel_y = 0;
			}
		}
		else if (vel_y >= 0)
		{
			var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, tile_layer);
			
			_floor_dist = _floor_data[0];
			_floor_angle = _floor_data[1];
		
			if (_floor_dist >= 0)
			{
				return;
			}
		
			spd_ground = vel_x;
			vel_y = 0;
		}
		else
		{
			return;
		}
		
		y += _floor_dist;
		angle = _floor_angle;
		
		land();
	}
}