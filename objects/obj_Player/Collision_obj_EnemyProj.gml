/// Take Damage

if (global.PlayerShield > 0)
{
	global.PlayerShield = clamp(global.PlayerShield - other.ShieldDamage, 0, global.PlayerMaxShield);
	if (ShieldFull == 0) ShieldRegen = 180;
}
else global.PlayerHP -= other.Damage;

StunT += other.Stun;

with (other)
{
	instance_create_depth(x, y, 0, obj_Hit);
	instance_destroy();
}