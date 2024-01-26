/// Step

DT += 1;

// Camera
var xto = obj_Player.x;
var yto = obj_Player.y;

if (global.CombatEnemy >= 0)
{
	if (instance_exists(global.CombatEnemy))
	{
		var xto = (obj_Player.x + global.CombatEnemy.x) / 2;
		var yto = (obj_Player.y + global.CombatEnemy.y) / 2;
	}
	else global.CombatEnemy = -1;
}

var xo = global.CamX;
var yo = global.CamY;
var difx = xto - xo;
var dify = yto - yo;
if (abs(difx) < 1) xo = xto else xo += difx / 16;
if (abs(dify) < 1) yo = yto else yo += dify / 16;
global.CamX = xo;
global.CamY = yo;
camera_set_view_pos(view_camera, global.CamX - 32, global.CamY - 32);
global.DrawX = global.CamX - 32;
global.DrawY = global.CamY - 32;

// Asteroids
if (AsteroidTimer > 0) AsteroidTimer -= 1;
else
{
	Nearby = 0;
	with (obj_Asteroid) { if (distance_to_object(obj_Player) < 48) other.Nearby += 1; }
	if (Nearby >= 10) AsteroidTimer = irandom_range(160, 200);
	else AsteroidTimer = irandom_range(240, 300);
	instance_create_depth(global.DrawX + random_range(4, 60), global.DrawY + random_range(4, 60), 0, obj_Asteroid);
}