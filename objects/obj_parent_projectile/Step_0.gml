if (!is_reflected)
{
	for (var _p = 0; _p < PLAYER_COUNT; _p++)
	{
		var _player = player_get(_p);
		if (!obj_check_hitbox(_player))
		{
			continue;
		}
		
		if (global.player_shields[_p] > SHIELD.NORMAL || _player.shield_state == SHIELDSTATE.DOUBLESPIN)
		{
			var _arctan = darctan2(_player.y - y, _player.x - x);
			var _angle = math_get_angle_rounded(_arctan);
			is_reflected = true;
			vel_x = -8 * dcos(_angle);
			vel_y = -8 * dsin(_angle);
			grv = 0;
			break;
		}
		else
		{
			_player.hurt();
		}
	}
}

x += vel_x;
y += vel_y;
vel_y += grv;