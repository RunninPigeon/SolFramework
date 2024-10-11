time_left = 659;
character_main = noone;
character_buddy = noone;
continue_count = global.continue_count;
continue_icons = [];
half_width = camera_get_width(0) / 2;
half_height = camera_get_height(0) / 2;

switch (global.player_main)
{
    case PLAYER.SONIC:
        character_main = obj_continue_sonic;
    break;
	
    case PLAYER.TAILS:
        character_main = obj_continue_tails;
    break;
	
    case PLAYER.KNUCKLES:
        character_main = obj_continue_knuckles;
    break;
	
    case PLAYER.AMY:
        character_main = obj_continue_amy;
    break;
}

character_main = instance_create(half_width, half_height + 45, character_main);

switch (global.player_cpu)
{
    case PLAYER.TAILS:
        character_buddy = obj_continue_tails_buddy;
    break;
}

if (character_buddy != noone)
{
    character_main.x -= 9;
    character_buddy = instance_create(half_width + 24, half_height + 48, character_buddy);
}

if (continue_count > 1)
{
    var _shift = max(continue_count - 1, 0) * 10 + 2;
	
    for (var _i = 0; _i < continue_count; _i++)
    {
        continue_icons[_i] = instance_create(half_width + 20 * _i - _shift, half_height - 20, obj_gui_continue, { vd_is_screen_space: false });
    }
}

fade_perform_black(FADEROUTINE.IN, 1);
audio_play_bgm(snd_bgm_continue);