if (state == ANIMALSTATE.CAPSULE)
{
    if (--vd_release_timer == 0)
    {
		state = ANIMALSTATE.APPEAR;
		obj_set_priority(1);
    }
	
    exit;
}

x += vel_x;
y += vel_y;
vel_y += grv;

if (state == ANIMALSTATE.MOVE && obj_is_anim_stopped())
{
    image_index = 1 + (vel_y >= 0);
}

if (vel_y < 0)
{
    exit;
}

var _floor_dist = tile_find_v(x, y + 12, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];

if (_floor_dist >= 0)
{
    exit;
}

y += _floor_dist;
vel_y = vel_y_bounce;

if (state != ANIMALSTATE.APPEAR)
{
    exit;
}

image_xscale = vd_random_direction ? choose(1, -1) : -1;
vel_x = vel_x_bounce * image_xscale;
state = ANIMALSTATE.MOVE;

switch (sprite_index)
{
    case spr_animal_flicky:
	
        obj_set_anim(sprite_index, 4, 1, 1);
		grv = 0.09375;
		
	break;
	
    case spr_animal_cucky:
        obj_set_anim(sprite_index, 2, 1, 1);
    break;
}