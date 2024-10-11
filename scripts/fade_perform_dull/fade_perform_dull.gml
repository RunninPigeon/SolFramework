/// @self
/// @description Triggers a dull fade effect.
/// @param {Enum.FADEROUTINE} _routine The type of fade action (e.g., fade-in or fade-out).
/// @param {Real} _step_duration The time in game steps between updates of the fade effect, affecting both speed and smoothness.
/// @param {Bool} [_game_control] Whether to pause game updates during the fade (default is true).
function fade_perform_dull(_routine, _step_duration, _game_control = true)
{
	var _speed = _step_duration > 0 ? (1 / _step_duration) : 0;
	
	/// @feather ignore GM1041
	fade_perform
	(
		_routine, _routine == FADEROUTINE.IN ? FADETYPE.DULLSYNC : FADETYPE.DULLORDER, _speed, _step_duration, _game_control
	);
}