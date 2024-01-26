/// Collide

with (other)
{
	instance_create_depth(x, y, 0, obj_Hit);
	instance_destroy();
}

instance_create_depth(x, y, 0, obj_Hit);
instance_destroy();