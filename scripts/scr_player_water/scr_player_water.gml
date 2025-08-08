/// @self obj_player
/// @function scr_player_water()
function scr_player_water()
{
	gml_pragma("forceinline");
	
	/// @method _spawn_splash()
	var _spawn_splash = function()
	{
		if (vel_y == 0)
		{
			return;
		}
		
		var _glide_not_fall = action == ACTION.GLIDE && action_state != GLIDESTATE.FALL;
		if (_glide_not_fall || action == ACTION.CLIMB || cpu_state == CPUSTATE.RESPAWN)
		{
			return;
		}
		
		instance_create(x, obj_rm_stage.water_level, obj_water_splash);
		audio_play_sfx(snd_splash);
	}

	/// @method _set_gravity()
	var _set_gravity = function()
	{
		if (action != ACTION.FLIGHT && (action != ACTION.GLIDE || action_state == GLIDESTATE.FALL))
		{
			reset_gravity();
		}
	}
	
	if (!instance_exists(obj_rm_stage) || !obj_rm_stage.water_enabled || state == PLAYERSTATE.DEATH)
	{
		return;
	}
	
	var _water_run_level = obj_rm_stage.water_level - radius_y - 1;
	if (!is_water_running)
	{
		if (vel_y == 0 && abs(vel_x) >= 7 && floor(y) == _water_run_level)
		{
			is_water_running = true;
			facing = sign(vel_x);
			instance_create(0, 0, obj_water_trail, { vd_target_player: id });
		}
	}	
	else if (input_press.action_any)
	{
		// S3K introduces a chopped-off version of the jump routine to make a player jump if they weren't grounded
		is_water_running = false;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
		is_jumping = true;
		is_grounded = false;
		animation = ANIM.SPIN;
		
		// S3K does not check if the player is Knuckles and overrides vel_y with -6.5
		vel_y = jump_vel;
		
		// S3K does not play the sound, so if the game hasn't processed a jump via its default routine yet... yikes!
		audio_play_sfx(snd_jump);
	}
	else if (floor(y) >= _water_run_level && abs(vel_x) >= 7)
	{
		y = _water_run_level;
		vel_y = 0;
		
		if (!is_grounded && !input_press.left && !input_press.right)
		{
			vel_x -= 0.046875 * sign(vel_x);
		}
	}
	else
	{
		is_water_running = false;
	}
	
	var _shield = global.player_shields[player_index];
	if (!is_underwater)
	{
		if (floor(y) < obj_rm_stage.water_level)
		{
			return;
		}
	
		is_underwater = true;
		air_timer = AIR_TIMER_DEFAULT;
		vel_x *= 0.5;
		vel_y *= 0.25;
		
		_set_gravity();
		_spawn_splash();
		instance_create(0, 0, obj_bubbles_player, { vd_target_player: id });
		
		if (_shield == SHIELD.FIRE || _shield == SHIELD.LIGHTNING)
		{
			if (_shield == SHIELD.LIGHTNING)
			{
				instance_create(x, y, obj_water_flash);
			}
			else if (_shield == SHIELD.FIRE)
			{
				instance_create(x, obj_rm_stage.water_level, obj_explosion_dust, { vd_make_sound: false });
			}
			
			global.player_shields[player_index] = SHIELD.NONE;
		}
	}

	if (_shield != SHIELD.BUBBLE)
	{
		if (air_timer > 0)
		{
			air_timer--;
		}
	
		switch (air_timer)
		{
			case 1500: 
			case 1200:
			case 900:
			
				if (player_index == 0)
				{
					audio_play_sfx(snd_alert);
				}
				
			break;
			
			case 720:
			
				if (player_index == 0)
				{
					audio_play_bgm(snd_bgm_drowning);
				}
				
			break;
			
			case 0:
			
				audio_play_sfx(snd_drown);
				reset_substate();
				
				depth = RENDERER_DEPTH_HIGHEST + player_index;
				grv = PARAM_GRV_UNDERWATER;
				state = PLAYERSTATE.DEATH;
				animation = ANIM.DROWN;
				vel_x = 0;
				vel_y = 0;
				spd_ground = 0;
				
				if (player_index == camera_data.index)
				{
					camera_data.allow_movement = false;
				}
				
			return;
		}
	}
	
	if (floor(y) >= obj_rm_stage.water_level)
	{
		return;
	}

	is_underwater = false;
	
	_set_gravity();
	_spawn_splash();

	if (action == ACTION.FLIGHT)
	{
		audio_play_sfx(snd_flight);
	}

	if (player_index == 0 && audio_is_playing(snd_bgm_drowning))
	{
		audio_reset_bgm(obj_rm_stage.bgm_track, id);
	}

	if (global.player_physics <= PHYSICS.S2 || vel_y >= -4)
	{
		vel_y *= 2;
	}
	
	vel_y = max(-16, vel_y);
}