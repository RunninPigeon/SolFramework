for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	if (_p == 0)
	{
		visible = _player.state == PLAYERSTATE.DEBUG_MODE;
	}
	
	if (_player.state >= PLAYERSTATE.LOCKED || !_player.is_grounded && vd_ground_only)
	{
		continue;
	}
	
	var _y_last = _player.yprevious;
	var _y = _player.y;
	var _x = _player.x;
	
	if (_x < bbox_left || _x >= bbox_right)
	{
		continue;
	}
	
	if (_y_last < y && _y >= y)
	{
		_player.secondary_layer = layer_data[1];
	}
	else if (_y_last >= y && _y < y)
	{
		_player.secondary_layer = layer_data[0];
	}
}