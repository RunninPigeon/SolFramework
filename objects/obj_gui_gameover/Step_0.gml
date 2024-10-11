if (obj_framework.fade_state  == FADESTATE.PLAINCOLOUR)
{	
	if (image_index == 1)
	{
		if (is_not_null_array(global.checkpoint_data))
		{
			global.checkpoint_data[2] = 0;
		}
		
		game_clear_temp_data(false);
		room_restart();
	}
	else
	{
		global.life_count = 3;
		global.score_count = 0;
		
		game_save_data(global.current_save_slot);
		game_clear_temp_data();
		
		if (global.continue_count > 0)
		{
			room_goto(rm_continue);
		}
		else
		{
			room_goto(global.start_room);
		}
	}
	
	exit;
}
	
switch (state)
{
	case GAMEOVERSTATE.SLIDE_IN:
			
		offset_x = max(offset_x - speed_x, 0);
		
		if (offset_x == 0)
		{
			state = GAMEOVERSTATE.WAIT;
		}
		
	break;
		
	case GAMEOVERSTATE.WAIT:
			
		if (input_get_pressed(0).action_any || wait_timer == 0)
		{
			state++;
			
			audio_stop_bgm(0.5);
			fade_perform_black(FADEROUTINE.OUT, 1);	
			
			break;
		}
		
		wait_timer--;
			
	break;
}