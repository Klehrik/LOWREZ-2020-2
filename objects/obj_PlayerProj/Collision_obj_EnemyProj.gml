/// Collide

instance_create_depth(x, y, 0, obj_Hit);

if (Collide < other.Collide) instance_destroy();
else if (Collide == other.Collide) { instance_destroy(); instance_destroy(other); }
else if (Collide > other.Collide) instance_destroy(other);