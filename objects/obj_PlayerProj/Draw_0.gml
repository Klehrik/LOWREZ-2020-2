/// Draw

if (Wait > 0) Wait -= 1;
else
{
	if (SetStats == 0)
	{
		SetStats = 1;
		var sprite_table = [spr_Blaster, spr_Blaster, spr_Stunner, spr_Stunner, spr_Breacher, spr_Breacher, spr_Breacher, -1, -1, spr_Blaster, -1, 0, -1, spr_Burst, spr_Burst];
		var image_table = [0, 1, 0, 1, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 1];
		var speed_table = [1.4, 1.2, 1.2, 1, 1.2, 1, 0.8, 0, 0, 1.4, 0, 0, 0, 0.8, 0.8];
		var collide_table = [1, 2, 2, 2, 2, 2, 3, 1, 3, 2, 3, 2, 2, 2, 3];
		var damage_table =        [1, 2, 0, 1, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1];
		var shield_damage_table = [1, 2, 0, 1, 2, 4, 9, 1, 1, 1, 1, 2, 1, 1, 1];
		var stun_table = [0, 0, 60, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var spread_table = [8, 8, 8, 6, 8, 6, 0, 0, 0, 22, 16, 0, 0, 35, 35];
		var laser_colour_table = [0, 0, 0, 0, 0, 0, 0, $36e400, $ffad29, 0, $36e400, 0, $ffad29, 0, 0];
		var max_travel_table = [1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 29, 29];
		sprite_index = sprite_table[Weapon];
		image_index = image_table[Weapon];
		Speed = speed_table[Weapon];
		Collide = collide_table[Weapon];
		Damage = damage_table[Weapon];
		ShieldDamage = shield_damage_table[Weapon];
		Stun = stun_table[Weapon];
		image_angle += random_range(-spread_table[Weapon] / 2, spread_table[Weapon] / 2);
		LaserC = laser_colour_table[Weapon];
		MaxTravel = max_travel_table[Weapon];
	}
	else
	{
		if (point_distance(x, y, CreationX, CreationY) > MaxTravel) { instance_create_depth(x, y, 0, obj_Hit); instance_destroy(); }
		
		if (sprite_index < 0)
		{
			if (LaserEndX == "")
			{
				LaserEndX = x;
				LaserEndY = y;
				while (point_distance(x, y, LaserEndX, LaserEndY) < 128)
				{
					LaserEndX += dcos(image_angle);
					LaserEndY -= dsin(image_angle);
					
					// Laser Collision Checks
					if (position_meeting(LaserEndX, LaserEndY, obj_Asteroid) or position_meeting(LaserEndX, LaserEndY, obj_EnemyProj))
					{
						var obj = instance_position(LaserEndX, LaserEndY, obj_Asteroid);
						if (obj < 0) var obj = instance_position(LaserEndX, LaserEndY, obj_EnemyProj);
						
						if (obj > -1)
						{
							instance_create_depth(LaserEndX, LaserEndY, 0, obj_Hit);
						
							if (Collide < other.Collide) break;
							else if (Collide == other.Collide) { break; instance_destroy(obj); }
							else if (Collide > other.Collide) instance_destroy(obj);
						}
					}
					
					if (position_meeting(LaserEndX, LaserEndY, obj_Enemy))
					{
						var obj = instance_position(LaserEndX, LaserEndY, obj_Enemy);
						
						if (obj > -1)
						{
							if (obj.Shield > 0) { obj.Shield = clamp(obj.Shield - ShieldDamage, 0, obj.MaxShield); if (obj.ShieldFull == 0) obj.ShieldRegen = 180; }
							else obj.HP -= Damage;
						
							instance_create_depth(LaserEndX, LaserEndY, 0, obj_Hit);
							break;
						}
					}
				}
			}
			draw_set_alpha(image_alpha);
			draw_line_colour(x, y, LaserEndX, LaserEndY, LaserC, LaserC);
			draw_set_alpha(1);
			
			if (image_alpha > 0) image_alpha -= 0.1;
			else instance_destroy();
		}
		else
		{
			if (Speed <= 0) image_alpha = 0;
			else image_alpha = 1;

			motion_set(image_angle, Speed);
			
			draw_self();
			
			if (distance_to_object(obj_Player) > 128) instance_destroy();
		}
	}
}