/// Init

depth = -5000;

Music1 = audio_play_sound(mus_Travel, 0, 1);
Music2 = audio_play_sound(mus_Battle, 0, 1);
Music1Vol = 1;
Music2Vol = 0;
audio_sound_gain(Music2, 0, 0);

PausedDT = 0;

global.Paused = -1;
PausedImage = -1;

Border = -4;
BorderX = 0;
BorderY = 0;

Page = 1;