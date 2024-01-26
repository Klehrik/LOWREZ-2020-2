/// Draw

draw_set_font(fnt_PICO8);
draw_set_colour($c7c3c2);

PausedDT += 1;

// Fullscreen
if (keyboard_check_pressed(ord("F")))
{
	if (window_get_fullscreen()) window_set_fullscreen(0);
	else window_set_fullscreen(1);
}

// Music
if (global.CombatEnemy >= 0)
{
	if (Music1Vol > 0) Music1Vol -= 0.007;
	if (Music2Vol < 1) Music2Vol += 0.007;
}
else
{
	if (Music1Vol < 1) Music1Vol += 0.007;
	if (Music2Vol > 0) Music2Vol -= 0.007;
}

Music1Vol = clamp(Music1Vol, 0, 1);
Music2Vol = clamp(Music2Vol, 0, 1);
audio_sound_gain(Music1, Music1Vol, 0);
audio_sound_gain(Music2, Music2Vol, 0);

// Pause
if (keyboard_check_pressed(vk_space))
{
	global.Paused *= -1;
	if (global.Paused == 1)
	{
		Border = 4;
		instance_deactivate_all(1);
		if (!sprite_exists(PausedImage)) PausedImage = sprite_create_from_surface(application_surface, 0, 0, 64, 64, 0, 0, 0, 0);
	}
	else
	{
		Border = -4;
		Page = 1;
		instance_activate_all();
	}
}

// Draw PausedImages
if (global.Paused == 1) draw_sprite_ext(PausedImage, 0, global.DrawX, global.DrawY, 1, 1, 0, c_white, 0.3);
else
{
	if (PausedImage != -1) sprite_delete(PausedImage);
	PausedImage = -1;
}

// Border
BorderX += Border;
if ((Border > 0 and BorderX >= 29) or (Border < 0 and BorderX <= 0)) BorderY += Border;
BorderX = clamp(BorderX, 0, 29);
BorderY = clamp(BorderY, 0, 29);

if (BorderX > 0) draw_rectangle(global.DrawX + 2 + (29 - BorderX), global.DrawY + 2 + (29 - BorderY), global.DrawX + 32 + BorderX, global.DrawY + 32 + BorderY, 1);

// Main
if (global.Paused == 1 and BorderX >= 28 and BorderY >= 28)
{
	var col = $27ecff;
	col = [col];
	
	if (keyboard_check_pressed(vk_left) and Page > 1) Page -= 1;
	if (keyboard_check_pressed(vk_right) and Page < 5) Page += 1;
	
	if (Page > 1) draw_sprite(spr_PauseArrows, 0, global.DrawX + 5 + sin(PausedDT / 20) * 1.4, global.DrawY + 55);
	if (Page < 5) draw_sprite_ext(spr_PauseArrows, 0, global.DrawX + 59 - sin(PausedDT / 20) * 1.4, global.DrawY + 55, -1, 1, 0, c_white, 1);
	
	if (Page == 1)
	{
		draw_text_colour(global.DrawX + 4, global.DrawY + 4, "Ship", col[0], col[0], col[0], col[0], 1);
		draw_sprite(spr_Icons, 0, global.DrawX + 4, global.DrawY + 13);
		draw_text(global.DrawX + 13, global.DrawY + 13, string(global.PlayerHP) + "/" + string(global.PlayerMaxHP) + " Energy");
		draw_sprite(spr_Icons, 1, global.DrawX + 4, global.DrawY + 20);
		draw_text(global.DrawX + 13, global.DrawY + 20, string(global.PlayerShield) + "/" + string(global.PlayerMaxShield) + " Shield");
		draw_sprite(spr_Icons, 2, global.DrawX + 4, global.DrawY + 27);
		draw_text(global.DrawX + 13, global.DrawY + 27, string(global.PlayerModules) + " Modules");
		draw_sprite(spr_Icons, 3, global.DrawX + 4, global.DrawY + 34);
		draw_text(global.DrawX + 13, global.DrawY + 34, string(global.PlayerPWR) + "/" + string(global.PlayerMaxPWR) + " PWR Used");
		draw_sprite(spr_Icons, 4, global.DrawX + 4, global.DrawY + 41);
		draw_text(global.DrawX + 13, global.DrawY + 41, string(global.PlayerSlots) + " Wep Slot");
	}
}