/// @self
/// @description Loads the saved data for the specified slot.
/// @param {Real} _slot The slot index of the saved data to load.
function game_load_data(_slot)
{
	var _filename = "save" + string(_slot) + ".bin";
	if (_slot == -1 || !file_exists(_filename))
	{
		return;
	}
	
	var _file = file_bin_open(_filename, 0);
	global.stage_index = file_bin_read_byte(_file);
	global.player_main = file_bin_read_byte(_file);
	global.player_cpu = file_bin_read_byte(_file);
	global.emerald_count = file_bin_read_byte(_file);
	global.continue_count = file_bin_read_byte(_file);
	global.life_count = file_bin_read_byte(_file);
	global.score_count = 0;

	for (var _i = 0; _i < 4; _i++) 
	{
		global.score_count += file_bin_read_byte(_file) * power(100, _i);
	}

	file_bin_close(_file);
}