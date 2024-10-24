/// @self
/// @description Retrieves the current input state (held down) for the specified slot.
/// @param {Real|Any} _slot The input slot number.
/// @returns {Struct}
function input_get(_slot)
{
	return obj_framework.input_list_down[| _slot];
}