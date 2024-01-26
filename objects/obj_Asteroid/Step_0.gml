/// Step

if (Prepare > 0) { Prepare -= 1; image_alpha = 0; }
else image_alpha = 1;

motion_set(Angle, Speed);

image_angle += 1;