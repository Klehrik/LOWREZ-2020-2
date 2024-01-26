/// Step

// Diagonal Speed = sqrt(Speed * Speed / 2)

// Set Max Speed
if ((keyboard_check(vk_left) or keyboard_check(vk_right)) and (keyboard_check(vk_up) or keyboard_check(vk_down))) MaxSpeed = 0.32;
else MaxSpeed = 0.44;

// HSP
if (StunT <= 0)
{
	if (keyboard_check(vk_left)) HSP -= 0.04;
	if (keyboard_check(vk_right)) HSP += 0.04;
}
if ((keyboard_check(vk_left) and keyboard_check(vk_right)) or (!keyboard_check(vk_left) and !keyboard_check(vk_right)) or (StunT > 0))
{
	if (HSP > 0) HSP -= 0.01;
	if (HSP < 0) HSP += 0.01;
}
if (abs(HSP) > MaxSpeed) HSP = MaxSpeed * sign(HSP);
x += HSP;

// VSP
if (StunT <= 0)
{
	if (keyboard_check(vk_up)) VSP -= 0.04;
	if (keyboard_check(vk_down)) VSP += 0.04;
}
if ((keyboard_check(vk_up) and keyboard_check(vk_down)) or (!keyboard_check(vk_up) and !keyboard_check(vk_down)) or (StunT > 0))
{
	if (VSP > 0) VSP -= 0.01;
	if (VSP < 0) VSP += 0.01;
}
if (abs(VSP) > MaxSpeed) VSP = MaxSpeed * sign(VSP);
y += VSP;

// Prevent out of bounds
if (x < global.DrawX + 4) x = global.DrawX + 4;
if (x > global.DrawX + 59) x = global.DrawX + 59;
if (y < global.DrawY + 4) y = global.DrawY + 4;
if (y > global.DrawY + 59) y = global.DrawY + 59;

// Sprite
if (global.CombatEnemy < 0)
{
	if (keyboard_check(vk_left) and keyboard_check(vk_up)) AngleTo = 135;
	else if (keyboard_check(vk_right) and keyboard_check(vk_up)) AngleTo = 45;
	else if (keyboard_check(vk_left) and keyboard_check(vk_down)) AngleTo = 225;
	else if (keyboard_check(vk_right) and keyboard_check(vk_down)) AngleTo = 315;
	else if (keyboard_check(vk_left)) AngleTo = 180;
	else if (keyboard_check(vk_right)) AngleTo = 0;
	else if (keyboard_check(vk_up)) AngleTo = 90;
	else if (keyboard_check(vk_down)) AngleTo = 270;
}
else if (instance_exists(global.CombatEnemy))
{
	AngleTo = point_direction(x, y, global.CombatEnemy.x, global.CombatEnemy.y);
}

var dd = angle_difference(image_angle, AngleTo);
if (abs(dd) > 5) image_angle -= 9 * sign(dd);

// Lock onto an enemy
if (distance_to_object(obj_Enemy) > 76) global.CombatEnemy = -1;
else if (distance_to_object(obj_Enemy) < 48) global.CombatEnemy = instance_nearest(x, y, obj_Enemy);
if (global.CombatEnemy >= 0) global.CombatEnemy = instance_nearest(x, y, obj_Enemy);

// =====

// Stun Timer
if (StunT > 0) StunT -= 1;

// Shield Regen
if (ShieldFull == 0)
{
	if (global.PlayerShield >= global.PlayerMaxShield) ShieldRegen = 180;
	if (global.PlayerShield <= 0) { ShieldFull = 1; ShieldRegen = 421; }
	
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else
	{
		global.PlayerShield += 1;
		ShieldRegen = 60;
	}
}
else if (ShieldFull == 1)
{
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else { ShieldRegen = floor(30 / global.PlayerMaxShield); ShieldFull = 2; }
}
else
{
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else
	{
		global.PlayerShield += 1;
		ShieldRegen = floor(30 / global.PlayerMaxShield);
	}
	
	if (global.PlayerShield >= global.PlayerMaxShield) ShieldFull = 0;
}

// global.Weapons
if (global.Weapon1[1] < global.Weapon1[2] and StunT <= 0) global.Weapon1[1] += 1;
if (global.Weapon2[1] < global.Weapon2[2] and StunT <= 0) global.Weapon2[1] += 1;

if (keyboard_check(ord("Z")) and global.Weapon1[1] >= global.Weapon1[2])
{
	if (global.CombatEnemy >= 0)
	{
		global.Weapon1[1] = 0;
		
		var enm = instance_nearest(x, y, obj_Enemy);
		
		for (var i = 0; i < global.Weapon1[3]; i++)
		{
			var proj = instance_create_depth(x, y, 0, obj_PlayerProj);
			proj.image_angle = point_direction(x, y, enm.x, enm.y);
			proj.Weapon = global.Weapon1[0];
		}
	}
}
if (keyboard_check(ord("X")) and global.Weapon2[1] >= global.Weapon2[2])
{
	if (global.CombatEnemy >= 0)
	{
		global.Weapon2[1] = 0;
		
		var enm = instance_nearest(x, y, obj_Enemy);
		
		for (var i = 0; i < global.Weapon2[3]; i++)
		{
			var proj = instance_create_depth(x, y, 0, obj_PlayerProj);
			proj.image_angle = point_direction(x, y, enm.x, enm.y);
			proj.Weapon = global.Weapon2[0];
		}
	}
}

// Testing
if (keyboard_check_pressed(ord("G"))) { global.PlayerShield -= 1; ShieldRegen = 180; }