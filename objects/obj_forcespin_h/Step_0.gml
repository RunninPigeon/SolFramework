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
		
	var _x_last = _player.xprevious;
	var _x = _player.x;
	var _y = _player.y;
	
	if (_y < bbox_top || _y >= bbox_bottom)
	{
		continue;
	}
	
	if ((_x_last >= x || _x < x) && (_x_last < x || _x >= x))
	{
		continue;
	}
	
	_player.action = ACTION.NONE;
	_player.forced_roll = !_player.forced_roll;	
	_player.reset_gravity();
}