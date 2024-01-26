/// Take Damage

if (global.PlayerShield > 0) { global.PlayerShield = clamp(global.PlayerShield - 2, 0, global.PlayerMaxShield); ShieldRegen = 180; }
else global.PlayerHP -= 2;

with (other)
{
	instance_create_depth(x, y, 0, obj_Hit);
	instance_destroy();
}