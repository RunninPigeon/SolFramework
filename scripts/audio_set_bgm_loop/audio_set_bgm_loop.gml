/// @self
/// @description Sets loop points for a BGM sound asset.
/// @param {Asset.GMSound} _sound_id The sound asset.
/// @param {Real} _loop_start The start point of the loop in seconds.
/// @param {Real} _loop_end The end point of the loop in seconds.
function audio_set_bgm_loop(_sound_id, _loop_start, _loop_end)
{
	ds_map_add(global.looped_audio_data, _sound_id, [_loop_start, _loop_end]);
	
    // audio_sound_loop_start(_sound_id, _loop_start);
    // audio_sound_loop_end(_sound_id, _loop_end);
}