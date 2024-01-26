/// Take Damage

if (Shield > 0)
{
	Shield = clamp(Shield - other.ShieldDamage, 0, MaxShield);
	if (ShieldFull == 0) ShieldRegen = 180;
}
else HP -= other.Damage;

StunT += other.Stun;

with (other)
{
	instance_create_depth(x, y, 0, obj_Hit);
	instance_destroy();
}