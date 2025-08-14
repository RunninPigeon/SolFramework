/// @description Late Update
if (room == rm_startup)
{
	return;
}

// Run Path Step and pre-framework End Step for game objects
with (obj_game_object)
{
	event_user(11);
	event_user(12);
}

#region AUDIO

audio_emitter_gain(audio_emitter_sfx, global.sound_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	var _state = audio_channel_states[_i];
    var _bgm = audio_channel_bgms[_i];
	
    if (_bgm == -1)
    {
        continue;
    }
	
    audio_emitter_gain(audio_emitter_bgm[_i], global.music_volume);
	
    if (audio_sound_length(_bgm) == -1 || _state == CHANNELSTATE.STOP && audio_sound_get_gain(_bgm) == 0)
    {
		audio_channel_states[_i] = CHANNELSTATE.DEFAULT;
		audio_channel_bgms[_i] = -1;
		audio_stop_sound(_bgm);
		
        continue;
    }
	
    if (_i == AUDIO_CHANNEL_JINGLE)
    {
        continue;
    }
	
	// TODO: remove this and audio_current_loop_data in LTS'25
	var _loop_data = audio_current_loop_data[_i];
	if (_loop_data != undefined)
	{
	    var _loop_start = _loop_data[0];
	    var _loop_end = _loop_data[1];
	    var _next_pos = audio_sound_get_track_position(_bgm) + (delta_time / 1000000);
		
	    if (_next_pos >= _loop_end)
		{
	        var _overshoot = _next_pos - _loop_end;
			var _loop_length = _loop_end - _loop_start;
	        var _new_pos = _loop_start + (_overshoot mod _loop_length);
			
	        audio_sound_set_track_position(_bgm, _new_pos);
	    }
	}
	
    var _jingle_bgm = audio_channel_bgms[AUDIO_CHANNEL_JINGLE];
    if (_jingle_bgm != -1)
    {
        if (_state != CHANNELSTATE.MUTE)
        {
            audio_channel_states[_i] = CHANNELSTATE.TEMPMUTE;
        }
		
        audio_mute_bgm(0.0, _i);
    }
    else if (_state == CHANNELSTATE.TEMPMUTE)
    {
        audio_unmute_bgm(1.0, _i);
    }
}

#endregion

#region CAMERA

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
    var _camera_data = camera_get_data(_i);
    if (_camera_data == undefined)
    {
        continue;
    }
	
	// Create a surface for the camera if it's non-existent. Doing so in a Draw event results in a blank frame
	if (!surface_exists(view_surface_id[_i]))
	{
		var _w = _camera_data.surface_w;
		var _h = _camera_data.surface_h;
		
		view_surface_palette[_i] = surface_create(_w, _h);
		view_surface_palette_faded[_i] = surface_create(_w, _h);
		view_surface_id[_i] = surface_create(_w, _h);
		
		surface_set_target(view_surface_id[_i]);
		draw_clear_alpha(c_fuchsia, 0);
		surface_reset_target();
	}
	
	if (state != GAMESTATE.PAUSED && _camera_data.allow_movement)
	{
		var _target = _camera_data.target;
	    if (_target != noone)
	    {
			instance_activate_object(_target);
			
			// Built-in object tracking system. The player object uses its own
			if (instance_exists(_target))
			{
		        var _width = camera_get_width(_i);
		        var _height = camera_get_height(_i);
		        var _target_x = _target.x - _camera_data.pos_x - _width * 0.5;
		        var _target_y = _target.y - _camera_data.pos_y - _height * 0.5 + 16;
				
				var _freespace_x = 16;
				var _freespace_y = 32;
				var _max_vel = 32;
			
		        if (_target_x > 0)
		        {
		            _camera_data.vel_x = min(_target_x, _max_vel);
		        }
		        else if (_target_x < -_freespace_x)
		        {
		            _camera_data.vel_x = max(_target_x + _freespace_x, -_max_vel);
		        }
		        else
		        {
		            _camera_data.vel_x = 0;
		        }
			 
		        if (_target_y > _freespace_y)
		        {
		            _camera_data.vel_y = min(_target_y - _freespace_y, _max_vel);
		        }
		        else if (_target_y < -_freespace_y)
		        {
		            _camera_data.vel_y = max(_target_y + _freespace_y, -_max_vel);
		        }
		        else
		        {
		            _camera_data.vel_y = 0;
		        }
		    }
		    else
		    {
		        _camera_data.target = noone;
		    }
		}
		
	    if (_camera_data.shake_timer > 0)
	    {
	        if (_camera_data.shake_offset == 0)
	        {
	            _camera_data.shake_offset = _camera_data.shake_timer;
	        }
	        else if (_camera_data.shake_offset < 0)
	        {
	            _camera_data.shake_offset = -1 - _camera_data.shake_offset;
	        }
	        else
	        {
	            _camera_data.shake_offset = -_camera_data.shake_offset;
	        }

	        _camera_data.shake_timer--;
	    }
	    else
	    {
	        _camera_data.shake_offset = 0;
	    }
		
	    if (_camera_data.delay_x == 0)
	    {
	        _camera_data.pos_x_prev = _camera_data.pos_x;
	        _camera_data.pos_x += _camera_data.vel_x;
	    }
	    else if (_camera_data.delay_x > 0)
	    {
	        _camera_data.delay_x--;
	    }

	    if (_camera_data.delay_y == 0)
	    {
	        _camera_data.pos_y_prev = _camera_data.pos_y;
	        _camera_data.pos_y += _camera_data.vel_y;
	    }
	    else if (_camera_data.delay_y > 0)
	    {
	        _camera_data.delay_y--;
	    }
	}
	
	var _x = clamp(floor(_camera_data.pos_x + _camera_data.offset_x), _camera_data.left_bound, _camera_data.right_bound - camera_get_width(_i)) + _camera_data.shake_offset;
    var _y = clamp(floor(_camera_data.pos_y + _camera_data.offset_y), _camera_data.top_bound, _camera_data.bottom_bound - camera_get_height(_i)) + _camera_data.shake_offset;
	
    camera_set_view_pos(view_camera[_i], _x - CAMERA_HORIZONTAL_BUFFER, _y);
}

#endregion

#region BACKGROUND

if (state != GAMESTATE.PAUSED)
{
	bg_scroll_x++;
	bg_scroll_y++;
}

#endregion

#region CULLING

// Parent check
with (obj_game_object)
{
	event_perform(ev_other, ev_user15);
}

#endregion

#region DISTORTION

if (state != GAMESTATE.PAUSED)
{
	for (var _i = ds_list_size(distortion_data) - 1; _i >= 0; _i--)
	{
		var _data = distortion_data[| _i];
		if (_data != undefined)
		{
			_data.offset -= _data.spd;
		}
	}
}

#endregion

#region GAMEPLAY

if (state != GAMESTATE.PAUSED)
{
    if (global.ring_spill_counter > 0)
    {
        global.ring_spill_counter--;
    }
	
	var _life_count_prev = global.life_count;
	
    if (global.player_rings >= global.life_rewards[0] && global.life_rewards[0] <= 200)
    {
        global.life_rewards[0] += RINGS_THRESHOLD;
		global.life_count++;
    }
	
    if (global.score_count >= global.life_rewards[1])
    {
        global.life_rewards[1] += SCORE_THRESHOLD;
		global.life_count++;
    }
	
	if (_life_count_prev != global.life_count)
	{
		audio_play_bgm(snd_bgm_extralife, AUDIO_CHANNEL_JINGLE);
	}
}

#endregion

#region SPRITE ANIMATOR

var _is_enabled = state != GAMESTATE.PAUSED;
if (_is_enabled != sprite_update_enabled)
{
    for (var _i = array_length(sprite_array) - 2; _i >= 0; _i -= 2)
    {
		/// @feather ignore GM1044
        sprite_set_speed(sprite_array[_i], _is_enabled ? (1 / sprite_array[_i + 1]) : 0, spritespeed_framespergameframe);
    }

    sprite_update_enabled = _is_enabled;
}

#endregion