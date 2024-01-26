/// Collide

instance_create_depth(x, y, 0, obj_Hit);

if (Collide == 1) instance_destroy();
else if (Collide == 2) { instance_destroy(); instance_destroy(other); }
else if (Collide == 3) instance_destroy(other);