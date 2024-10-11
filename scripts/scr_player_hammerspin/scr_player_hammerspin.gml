/// @function scr_player_hammerspin()
/// @self obj_player
function scr_player_hammerspin()
{
	gml_pragma("forceinline");

	if (action != ACTION.HAMMERSPIN)
	{
		exit;
	}
	
	if (is_grounded && dropdash_charge >= PARAM_DROPDASH_CHARGE)
	{
		animation = ANIM.HAMMERDASH;
		action = ACTION.HAMMERDASH;
		hammerdash_timer = 0;

		if (super_timer > 0 && player_index == camera_data.index)
		{
			camera_data.shake_timer = 6;
		}
	
		scr_player_hammerdash();
		audio_stop_sound(snd_charge3);
		audio_play_sfx(snd_release);
		
		exit;
	}

	if (input_down.action_any)
	{
		if (dropdash_charge >= 0)
		{
			if (++dropdash_charge == PARAM_DROPDASH_CHARGE)
			{
				audio_play_sfx(snd_charge3);
			}
		}
	
		air_lock_flag = false;
	}
	else if (dropdash_charge > 0)
	{
		dropdash_charge = dropdash_charge >= PARAM_DROPDASH_CHARGE ? -1 : 0;
	}
}
