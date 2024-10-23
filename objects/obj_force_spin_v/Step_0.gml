visible = global.debug_collision > 0;

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	var _player = player_get(_p);
	
	if (_p == 0)
	{
		visible |= _player.state == PLAYERSTATE.DEBUG_MODE;
	}
	
	if (_player.state >= PLAYERSTATE.NO_CONTROL)
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
	
	if ((_y_last >= y || _y < y) && (_y_last < y || _y >= y))
	{
		continue;
	}
	
	_player.action = ACTION.NONE;
	_player.forced_roll = !_player.forced_roll;		
	_player.m_player_reset_gravity();
}