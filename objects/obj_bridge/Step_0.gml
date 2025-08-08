var _max_dip = 0;
var _player_touch = false;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
	obj_act_solid(_player, SOLIDOBJECT.TOP);
	
	if (!obj_check_solid(_player, SOLIDCOLLISION.TOP))
	{
		continue;
	}
	
	_player_touch = true;
	var _active_log = clamp
	(
		floor(floor(_player.x - x + log_amount * log_size_half) / log_size) + 1, 1, log_amount
	);
		
	var _dip_value = dip[_active_log - 1];
	if (_dip_value > _max_dip)
	{
		active_log = _active_log;
		max_dip = _dip_value;
		
		_max_dip = max_dip;
	}
	
	_player.y += round(_dip_value * dsin(angle));
}

for (var _i = 0; _i < log_amount; _i++)
{
	var _log_diff = abs(_i + 1 - active_log);
	var _log_dist = 1;
	
	if (_i < active_log)
	{
		_log_dist -= _log_diff / active_log;
	}
	else
	{
		_log_dist -= _log_diff / (log_amount - active_log + 1);
	}
	
	log_y[_i] = y + round(max_dip * dsin(90 * _log_dist) * dsin(angle));
}

if (_player_touch)
{
	if (angle < 90)
	{
		angle += 5.625;
	}	
}
else if (angle > 0)
{
	angle -= 5.625;
}