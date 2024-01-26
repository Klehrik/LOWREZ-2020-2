/// Take Damage

if (Shield > 0) { Shield = clamp(Shield - 2, 0, MaxShield); if (ShieldFull == 0) ShieldRegen = 180; }
else HP -= 2;

with (other)
{
	instance_create_depth(x, y, 0, obj_Hit);
	instance_destroy();
}