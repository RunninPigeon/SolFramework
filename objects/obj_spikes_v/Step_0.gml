if (vd_move_spikes)
{
    if (retract_timer > 0)
    {
        if (--retract_timer == 0 && obj_is_visible())
        {
            audio_play_sfx(snd_spikes_move);
        }
    }
    else
    {
        retract_offset += 8 * retract_direction;
        if (abs(retract_offset) >= retract_distance || sign(image_yscale) != sign(retract_offset))
        {
            if (image_yscale > 0)
            {
                retract_offset = clamp(retract_offset, 0, retract_distance);
            }
            else if (image_yscale < 0)
            {
                retract_offset = clamp(retract_offset, -retract_distance, 0);
            }

            retract_timer = 60;
            retract_direction *= -1;
        }
    }

    y = ystart + retract_offset;
}

for (var _p = 0; _p < PLAYER_COUNT; _p++)
{
    var _player = player_get(_p);
    var _attach_type = _player.is_invincible() ? SOLIDATTACH.DEFAULT : SOLIDATTACH.RESET_PLAYER;
    var _collision_side = image_yscale >= 0 ? SOLIDCOLLISION.TOP : SOLIDCOLLISION.BOTTOM;

    obj_act_solid(_player, SOLIDOBJECT.FULL, _attach_type);

    if (obj_check_solid(_player, _collision_side))
    {
        _player.hurt(snd_spikes_hurt);
    }
}