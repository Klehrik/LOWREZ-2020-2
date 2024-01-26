/// Init

image_speed = 0;
image_index = irandom_range(0, 2);

Angle = point_direction(x, y, global.CamX, global.CamY) + random_range(-45, 45);
Speed = random_range(0.2, 0.3);

x -= dcos(Angle) * 96;
y += dsin(Angle) * 96;

Prepare = 2;