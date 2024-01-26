/// Step

// Movement
if (global.CombatEnemy >= 0 and distance_to_object(obj_Player) < 96)
{
	if (StunT <= 0)
	{
		if (distance_to_object(obj_Player) > 48)
		{
			MoveAngle = point_direction(x, y, obj_Player.x, obj_Player.y);
			RandomSpeedT = 30;
			MoveAngleInc = 0;
			MoveAngleT = 30;
			if (Speed < 0.3) Speed += 0.01;
		}
		else if (Flee == 1)
		{
			if (distance_to_object(obj_Player) < 28)
			{
				MoveAngle = point_direction(x, y, obj_Player.x, obj_Player.y) - 180;
				RandomSpeedT = 30;
				MoveAngleInc = 0;
				MoveAngleT = 30;
				if (Speed < 0.3) Speed += 0.01;
			}
			else { Flee = 0; MoveAngle = point_direction(x, y, obj_Player.x, obj_Player.y) + choose(-90, 90); }
		}
		else if (distance_to_object(obj_Player) < 16) Flee = 1;
		else
		{
			if (RandomSpeedT > 0) RandomSpeedT -= 1;
			else { RandomSpeed = random_range(0, 0.3); RandomSpeedT = irandom_range(60, 120); }
			if (Speed < RandomSpeed) Speed += 0.01;
			else if (Speed > RandomSpeed) Speed -= 0.01;
			if (abs(Speed) - RandomSpeed < 0.01) Speed = RandomSpeed;
		
			if (MoveAngleT > 0) MoveAngleT -= 1;
			else
			{
				if (MoveAngleZero == 2) MoveAngleInc = random_range(-1.5, 1.5);
				else MoveAngleInc = 0;
				MoveAngleT = irandom_range(90, 150);
				MoveAngleZero += 1;
				if (MoveAngleZero > 2) MoveAngleZero = 0;
			}
		}
		
		// Try to spread out
		if (collision_line(x, y, obj_Player.x, obj_Player.y, obj_Enemy, 0, 1)) MoveAngle += choose(-90, 90);
		
		// Prevent moving into asteroids
		if (collision_line(x, y, x + dcos(MoveAngle) * 4, y - dsin(MoveAngle) * 4, obj_Asteroid, 0, 1)) MoveAngle += choose(-90, 90);
	}
	else { if (Speed > 0) Speed = clamp(Speed - 0.1, 0, 0.3); }
	MoveAngle += MoveAngleInc;
	MoveAngleInc -= sign(MoveAngleInc) * 0.05;
	motion_set(MoveAngle, Speed);
}

// Stun Timer
if (StunT > 0) StunT -= 1;

// Weapon
if (global.CombatEnemy >= 0 and distance_to_object(obj_Player) < 56 and StunT <= 0)
{
	if (Weapon1T > 0) Weapon1T -= 1;
	else
	{
		Weapon1T = irandom_range(120, 150);

		var proj = instance_create_depth(x, y, 0, obj_EnemyProj);
		proj.image_angle = point_direction(x, y, obj_Player.x, obj_Player.y);
		if (irandom_range(1, 3) == 3)
		{
			var distance = distance_to_object(obj_Player);
			PrefireAngle = point_direction(x, y, obj_Player.x + obj_Player.HSP * distance, obj_Player.y + obj_Player.VSP * distance);
			PrefireAngleT = 30;
			proj.image_angle = PrefireAngle;
		}
		proj.Creator = id;
		proj.Weapon = 4;
	}
	
	if (Weapon2T > 0) Weapon2T -= 1;
	else
	{
		Weapon2T = irandom_range(90, 120);

		var proj = instance_create_depth(x, y, 0, obj_EnemyProj);
		proj.image_angle = point_direction(x, y, obj_Player.x, obj_Player.y);
		if (irandom_range(1, 3) == 3)
		{
			var distance = distance_to_object(obj_Player);
			PrefireAngle = point_direction(x, y, obj_Player.x + obj_Player.HSP * distance, obj_Player.y + obj_Player.VSP * distance);
			PrefireAngleT = 30;
			proj.image_angle = PrefireAngle;
		}
		proj.Creator = id;
		proj.Weapon = 0;
	}
}

// Sprite
if (PrefireAngleT > 0) { PrefireAngleT -= 1; AngleTo = PrefireAngle; }
else AngleTo = point_direction(x, y, obj_Player.x, obj_Player.y);
var dd = angle_difference(image_angle, AngleTo);
if (abs(dd) > 5) image_angle -= 9 * sign(dd);