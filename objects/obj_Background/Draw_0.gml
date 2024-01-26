/// Draw

depth = 1000;

// Background
var c = $351D11;
draw_rectangle_color(global.DrawX, global.DrawY, global.DrawX + 64, global.DrawY + 64, c, c, c, c, 0);

// Grid Lines
var MAX = 2048;
for (var i = 0; i <= MAX; i += 64)
{
	draw_set_alpha(0.05);
	draw_line(i, 0, i, MAX);
	draw_line(0, i, MAX, i);
	draw_set_alpha(1);
}