/// Draw

draw_self();

// Health Check
if (HP <= 0) instance_destroy();

// Shield
if (ShieldFull == 0)
{
	if (Shield >= MaxShield) ShieldRegen = 180;
	if (Shield <= 0) { ShieldFull = 1; ShieldRegen = 421; }
	
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else
	{
		Shield += 1;
		ShieldRegen = 60;
	}
}
else if (ShieldFull == 1)
{
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else { ShieldRegen = floor(30 / MaxShield); ShieldFull = 2; }
}
else
{
	if (ShieldRegen > 0) ShieldRegen -= 1;
	else
	{
		Shield += 1;
		ShieldRegen = floor(30 / MaxShield);
	}
	
	if (Shield >= MaxShield) ShieldFull = 0;
}
if (Shield > 0) draw_sprite_ext(spr_HUDShieldUp, 0, x, y, 1, 1, 0, c_white, abs(dsin(obj_Manager.DT / 2)) / 3);

// Indicator
if (distance_to_object(obj_Player) < 96 and !(x >= global.DrawX - 4 and x <= global.DrawX + 68 and y >= global.DrawY - 4 and y <= global.DrawY + 68))
{
	var X = global.CamX;
	var Y = global.CamY;
	var dir = point_direction(X, Y, x, y);
	
	while (X > global.DrawX + 6 and X < global.DrawX + 58 and Y > global.DrawY + 6 and Y < global.DrawY + 48)
	{
		X += dcos(dir) * 2;
		Y -= dsin(dir) * 2;
	}
	
	draw_sprite_ext(spr_Indicator, 0, X, Y, 1, 1, dir, c_white, 1);
}