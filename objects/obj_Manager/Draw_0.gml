/// Draw

// HUD
draw_sprite(spr_HUD, 0, global.DrawX, global.DrawY + 53);

// HUD: Health
for (var i = 0; i < global.PlayerMaxHP; i++)
{
	var s = 0;
	if (global.PlayerHP > i) { s = 1; if (global.PlayerShield > 0) s = 4; }
	draw_sprite(spr_Bar, s, global.DrawX + 6 + i, global.DrawY + 55);
}

// HUD: Shield
for (var i = 0; i < global.PlayerMaxShield; i++)
{
	var s = 2;
	if (global.PlayerShield > i) s = 3;
	draw_sprite(spr_Bar, s, global.DrawX + 6 + i, global.DrawY + 60);
}
var fr = 0;
if (DT mod 120 > 60) fr = 1;
if (global.PlayerShield > 0)
{
	draw_sprite(spr_HUDFrames, fr, global.DrawX + 4, global.DrawY + 53);
	draw_sprite_ext(spr_HUDShieldUp, 0, obj_Player.x, obj_Player.y, 1, 1, 0, c_white, abs(dsin(DT / 2)) / 3);
}

// HUD: Weapons
draw_sprite_ext(spr_Weapons, scr_weapon_icon_image(global.Weapon1[0]), global.DrawX + 21, global.DrawY + 56, 1, 1, 0, scr_weapon_icon_colour(global.Weapon1[0]), 1);
draw_sprite_ext(spr_Weapons, scr_weapon_icon_image(global.Weapon2[0]), global.DrawX + 42, global.DrawY + 56, 1, 1, 0, scr_weapon_icon_colour(global.Weapon2[0]), 1);
for (var i = 0; i < 10; i++)
{
	var s = 0;
	if (global.Weapon1[1] > global.Weapon1[2] / 10 * i) s = 5;
	draw_sprite(spr_Bar, s, global.DrawX + 28 + i, global.DrawY + 57);
}
for (var i = 0; i < 10; i++)
{
	var s = 0;
	if (global.Weapon2[1] > global.Weapon2[2] / 10 * i) s = 5;
	draw_sprite(spr_Bar, s, global.DrawX + 49 + i, global.DrawY + 57);
}
if (global.Weapon1[1] >= global.Weapon1[2]) draw_sprite(spr_HUDFrames, fr + 2, global.DrawX + 19, global.DrawY + 54);
if (global.Weapon2[1] >= global.Weapon2[2]) draw_sprite(spr_HUDFrames, fr + 2, global.DrawX + 40, global.DrawY + 54);

// HUD: Enemy Stats
if (global.CombatEnemy > -1 and instance_exists(global.CombatEnemy))
{
	var obj = global.CombatEnemy;
	for (var i = 0; i < obj.MaxHP; i++)
	{
		var s = 0;
		if (obj.HP > i) { s = 1; if (obj.Shield > 0) s = 4; }
		draw_sprite(spr_Bar, s, global.DrawX + 62 - i * 2, global.DrawY + 1);
	}
	for (var i = 0; i < obj.MaxShield; i++)
	{
		var s = 2;
		if (obj.Shield > i) s = 3;
		draw_sprite(spr_Bar, s, global.DrawX + 62 - i * 2, global.DrawY + 6);
	}
}

//if (global.CombatEnemy > -1 and instance_exists(global.CombatEnemy))
//{
//	var obj = global.CombatEnemy;
//	for (var i = 0; i < 10; i++)
//	{
//		var s = 0;
//		if (obj.HP > obj.MaxHP / 10 * i) { s = 1; if (obj.Shield > 0) s = 4; }
//		draw_sprite(spr_Bar, s, global.DrawX + 62 - i, global.DrawY + 1);
//	}
//	for (var i = 0; i < 10; i++)
//	{
//		var s = 2;
//		if (obj.Shield > obj.MaxShield / 10 * i) s = 3;
//		draw_sprite(spr_Bar, s, global.DrawX + 62 - i, global.DrawY + 6);
//	}
//}