if keyboard_check_pressed(vk_enter){
	audio_stop_sound(game_over)
	room_goto(Gameplay)
}

if keyboard_check_pressed(vk_space){
	audio_stop_sound(game_over)
	room_goto(Gameplay)
}

if keyboard_check_pressed(vk_backspace){
	audio_stop_sound(game_over)
	room_goto(menu)
}

if keyboard_check_pressed(vk_escape){
	audio_stop_sound(game_over)
	room_goto(menu)
}