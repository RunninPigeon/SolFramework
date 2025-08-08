/// @self
/// @description Retrieves the instance ID of a player object corresponding to the specified player index. Returns noone if no matching player object is found.
/// @param {Real} _player_index The index of the player.
/// @returns {Id.Instance}
function player_get(_player_index)
{
	// TODO: replace with return instance_find(obj_player, _player_index) in LTS'25
	with (obj_player)
	{
		if (player_index == _player_index)
		{
			return id;
		}
	}
	
	return noone;
}