switch (state)
{
    case RESULTSSTATE.LOAD:
	
        if (--state_timer > 0)
        {
            break;
        }
		
		// Fallthrough to RESULTSSTATE.MOVE
        state_timer = 180;
        state++;
	
    case RESULTSSTATE.MOVE:
    case RESULTSSTATE.WAIT_EXIT:
	
        if (state == RESULTSSTATE.MOVE)
        {
            offset_line1 = min(offset_line1 + speed_x, 0);
            offset_line2 = max(offset_line2 - speed_x, 0);
            offset_time = max(offset_time - speed_x, 0);
            offset_rings = max(offset_rings - speed_x, 0);
            offset_perfect = max(offset_perfect - speed_x, 0);
            offset_total = max(offset_total - speed_x, 0);
        }
		
        if (--state_timer != 0)
        {
            break;
        }
		
        if (state == RESULTSSTATE.WAIT_EXIT)
        {
			state = RESULTSSTATE.EXIT;
			
            if (obj_rm_stage.save_progress)
            {
                game_save_data(global.current_save_slot);
            }
			
            fade_perform_black(FADEROUTINE.OUT, 1);
        }
		else
		{
			state = RESULTSSTATE.TALLY;
		}
		
    break;
	
    case RESULTSSTATE.TALLY:
	
        if (time_bonus > 0 || ring_bonus > 0)
        {
            if (time_bonus > 0)
            {
                time_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if (ring_bonus > 0)
            {
                ring_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if (obj_framework.frame_counter % 4 == 0)
            {
                audio_play_sfx(snd_beep);
            }
			
            break;
        }
		
        state = RESULTSSTATE.WAIT_EXIT;
		
        if (total_bonus >= 10000)
        {
            state_timer = 300;
            global.continue_count++;
			
            instance_create(0, 0, obj_gui_continue, { visible: false });    
        }
        else
        {
            state_timer = 180;
        }
		
        audio_play_sfx(snd_tally);
		
    break;
    
    case RESULTSSTATE.EXIT:
	
        if (obj_framework.fade_state != FADESTATE.PLAINCOLOUR)
        {
            break;
        }
		
        game_clear_temp_data();
		
        if (obj_rm_stage.next_stage == -1)
        {
            room_restart();
        }
        else
        {
            room_goto(obj_rm_stage.next_stage);
        }
		
    break;
}