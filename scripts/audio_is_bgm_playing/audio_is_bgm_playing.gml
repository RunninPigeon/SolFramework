/// @self
/// @description Checks if BGM is playing on the specified channel.
/// @param {Real} [_index] The channel index (default is 0).
/// @returns {Bool}
function audio_is_bgm_playing(_index = 0)
{
    return obj_game.audio_channel_bgms[_index] != -1;
}