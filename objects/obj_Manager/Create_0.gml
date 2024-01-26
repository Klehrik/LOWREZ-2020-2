/// Init

surface_resize(application_surface, 64, 64);
randomize();
game_set_speed(60, gamespeed_fps);

keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("J"), ord("Z"));
keyboard_set_map(ord("K"), ord("X"));
keyboard_set_map(ord("1"), ord("Z"));
keyboard_set_map(ord("2"), ord("X"));
keyboard_set_map(ord("Q"), ord("Z"));
keyboard_set_map(ord("E"), ord("X"));
keyboard_set_map(vk_enter, vk_space);
keyboard_set_map(vk_shift, vk_space);

depth = -1000;

DT = 0;

global.CamX = obj_Player.x;
global.CamY = obj_Player.y;
global.DrawX = obj_Player.x - 32;
global.DrawY = obj_Player.y - 32;

global.CombatEnemy = -1;

AsteroidTimer = 300;