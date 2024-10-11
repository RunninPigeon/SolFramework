osc_angle = dsin(obj_framework.frame_counter * ANGLE_INCREMENT) * (vd_angle_range * 0.5);

x = math_oscillate_x(xstart, osc_angle, distance, 1, vd_angle_offset);
y = math_oscillate_y(ystart, osc_angle, distance, 1, false);
	
for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
	obj_act_solid(player_get(_p), SOLIDOBJECT.TOP);
}