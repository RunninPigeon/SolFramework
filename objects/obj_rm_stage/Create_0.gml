#region METHODS

/// @method setup_level()
setup_level = function(_stage_index, _name, _act_id, _bgm, _animals, _bottom_bound, _water_pos, _next_room, _do_save)
{
    global.stage_index = _stage_index;
    zone_name = _name;
    act_id = _act_id;
    bgm_track = _bgm;
    animal_set = _animals;
    water_enabled = _water_pos >= 0;
    water_level_init = _water_pos;
    water_level = _water_pos;
    next_stage = _next_room;
    save_progress = _do_save;
    bottom_bound_init = _bottom_bound;
}

#endregion

#macro ACT_SINGLE 3

zone_name = "TEMPLATE";
act_id = 0;
bgm_track = -1;
animal_set = [];
water_enabled = -1;
water_level_init = 0;
water_level = 0;
next_stage = -1;
save_progress = false;
end_bound = room_width;
bottom_bound_init = room_height;
bottom_bound = array_create(CAMERA_COUNT, room_height);
top_bound = array_create(CAMERA_COUNT, 0);
left_bound = array_create(CAMERA_COUNT, 0);
right_bound = array_create(CAMERA_COUNT, room_width);
bound_speed = array_create(CAMERA_COUNT, 0);

default_physics = global.player_physics;
default_range = global.rotation_range;

// Stage Setup
scr_stage_setup();

if (water_enabled)
{
    instance_create_depth(0, 0, RENDERER_DEPTH_HIGHEST, obj_water_surface);
}

instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_titlecard);
instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_hud);
audio_play_bgm(bgm_track);

var _ring_data = global.giant_ring_data;
var _checkpoint_data = global.checkpoint_data;

if (is_not_null_array(_ring_data))
{
	obj_game.frame_counter = _ring_data[2];
	
    for (var _i = 0; _i < CAMERA_COUNT; _i++)
    {
        top_bound[_i] = _ring_data[3];
        bottom_bound[_i] = _ring_data[4];
        left_bound[_i] = _ring_data[5];
        right_bound[_i] = _ring_data[6];
    }
}
else if (is_not_null_array(_checkpoint_data))
{
	obj_game.frame_counter = _checkpoint_data[2];
	
    for (var _i = 0; _i < CAMERA_COUNT; _i++)
    {
        top_bound[_i] = _checkpoint_data[3];
        bottom_bound[_i] = _checkpoint_data[4];
        left_bound[_i] = _checkpoint_data[5];
        right_bound[_i] = _checkpoint_data[6];
    }
}
else if (bottom_bound_init > 0)
{
    for (var _i = 0; _i < CAMERA_COUNT; _i++)
    {
        bottom_bound[_i] = bottom_bound_init;
    }
}

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
    var _camera_data = camera_get_data(_i);
    if (_camera_data != undefined)
    {
        _camera_data.top_bound = top_bound[_i];
        _camera_data.bottom_bound = bottom_bound[_i];
        _camera_data.left_bound = left_bound[_i];
        _camera_data.right_bound = right_bound[_i];
    }
}

var _player_icon = "";
switch (global.player_main)
{
    case PLAYER.SONIC:
        _player_icon = "player_sonic"; 
    break;
	
    case PLAYER.TAILS: 
        _player_icon = "player_tails";
    break;
	
    case PLAYER.KNUCKLES:
        _player_icon = "player_knuckles";
    break;
	
    case PLAYER.AMY:
        _player_icon = "player_amy"; 
    break;
}

var _stage_icon = "";
switch (room)
{
	case rm_stage_ghz0:
		_stage_icon = "stage_ghz";
	break;
	
	case rm_stage_ehz0:
		_stage_icon = "stage_ehz";
	break;
}

discord_set_data(zone_name, act_id == ACT_SINGLE ? "Single Act" : "Act " + string(act_id + 1), _stage_icon, _player_icon);