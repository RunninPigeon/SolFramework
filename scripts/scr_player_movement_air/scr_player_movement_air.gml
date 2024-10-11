/// @function scr_player_movement_air()
/// @self obj_player
function scr_player_movement_air()
{
	if (action == ACTION.CARRIED || action == ACTION.CLIMB || action == ACTION.SPINDASH 
	|| action == ACTION.DASH || action == ACTION.GLIDE && action_state != GLIDESTATE.FALL)
	{
		exit;
	}
	
	if (angle != 0)
	{
		if (angle >= 180)
		{
			angle += 2.8125;
		}
		else
		{
			angle -= 2.8125;
		}
		
		if (angle < 0 || angle >= 360)
		{
			angle = 0;
		}
	}

	if (!is_jumping && !forced_roll && action != ACTION.SPINDASH)
	{
		vel_y = max(-15.75, vel_y);
	}

	if (global.player_physics == PHYSICS.CD)
	{
		vel_y = min(vel_y, 16);
	}
	
	if (action == ACTION.HAMMERDASH)
	{
		exit;
	}

	if (!air_lock_flag)
	{
		if (input_down.left)
		{
			if (vel_x > 0)
			{
				vel_x -= acc_air;
			}
			else if (global.speed_cap || vel_x > -acc_top)
			{
				vel_x = max(vel_x - acc_air, -acc_top);
			}
			
			facing = DIRECTION.NEGATIVE;
		}
		
		if (input_down.right)
		{
			if (vel_x < 0)
			{
				vel_x += acc_air;
			} 
			else if (global.speed_cap || vel_x < acc_top)
			{
				vel_x = min(vel_x + acc_air, acc_top);
			}
			
			facing = DIRECTION.POSITIVE;
		}	
	}
	
	if (vel_y < 0 && vel_y > -4)
	{
		vel_x -= floor(vel_x / 0.125) / 256;
	}
}