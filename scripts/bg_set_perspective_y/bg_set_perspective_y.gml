/// @self
/// @description Sets a vertical perspective effect on the most recent background layer. Only one vertical perspective layer is supported.
/// @param {Real} _target_y The y position in the room for scaling the layer.
function bg_set_perspective_y(_target_y)
{
	with (obj_framework)
	{
		var _layer_index = bg_layer_count - 1;
		var _pd = bg_parallax_data[_layer_index];
		
		bg_perspective_data = [_target_y, _target_y, _pd.offset_y, _layer_index];
	}
}