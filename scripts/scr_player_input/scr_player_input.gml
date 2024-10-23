/// @function scr_player_input()
function scr_player_input()
{
	gml_pragma("forceinline");
	
	var _replay_data_buttons = array_length(replay_data);
	
	if (_replay_data_buttons > 0)
	{
		var _inputs = array_create(_replay_data_buttons, false);	
		var _keys = variable_struct_get_names(input_down);
		
		for (var _i = 0; _i < _replay_data_buttons; _i++)
		{
			var _key = _keys[_i];
			var _button_timers = replay_data[_i];
			var _timers_total = array_length(_button_timers);
			
			if (replay_button_state[_i] < _timers_total)
			{
				if (replay_button_timer[_i] < 0)
				{
					replay_button_timer[_i] = _button_timers[0];
				}
			
				if (replay_button_timer[_i] > 0)
				{
					replay_button_timer[_i]--;
				}
				else if (++replay_button_state[_i] < _timers_total)
				{
					replay_button_timer[_i] = _button_timers[replay_button_state[_i]];
				}
				
				_inputs[_i] = replay_button_state[_i] % 2;
			}
		
			input_press[$ _key] = _inputs[_i] && !input_down[$ _key];			
			input_down[$ _key] = _inputs[_i];
		}

		return;
	}
	
	if (input_no_control)
	{
		return;
	}
	
	if (player_index < INPUT_SLOT_COUNT)
	{
		input_press = struct_copy(input_get_pressed(player_index));
		input_down = struct_copy(input_get(player_index));
	}
	else
	{
		input_reset(input_press);
		input_reset(input_down);
	}
}