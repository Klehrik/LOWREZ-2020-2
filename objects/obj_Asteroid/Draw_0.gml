/// Draw

draw_self();

if (distance_to_object(obj_Player) < 64 and !(x >= global.DrawX - 4 and x <= global.DrawX + 68 and y >= global.DrawY - 4 and y <= global.DrawY + 68))
{
	var X = global.CamX;
	var Y = global.CamY;
	var dir = point_direction(X, Y, x, y);
	
	while (X > global.DrawX + 6 and X < global.DrawX + 58 and Y > global.DrawY + 6 and Y < global.DrawY + 48)
	{
		X += dcos(dir) * 2;
		Y -= dsin(dir) * 2;
	}
	
	draw_sprite_ext(spr_Indicator, 1, X, Y, 1, 1, dir, c_white, 1);
}