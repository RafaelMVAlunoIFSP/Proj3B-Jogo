/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if not(tocouPlayer) {
	tocouPlayer = true
	//hspeed += 0
	global.player_dead_state = true
	audio_play_sound(som_hit_player,1,false)
	//vivo = false
	//draw_text_transformed(480,200,"GAME OVER",0.5,0.5,0)
	//show_debug_message("Tocou player no tempo: {}, get_timer()")
}
else{
	//tocouPlayer = true
}




//show_debug_message(string("Tocou player no tempo: {0}", get_timer()))
