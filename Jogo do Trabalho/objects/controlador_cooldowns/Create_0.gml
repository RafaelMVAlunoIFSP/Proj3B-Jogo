/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

function pausar_cooldown_projeteis(){
	alarm[0]++
}

function pausar_cooldown_spawn(){
	alarm[1]++
}

alarm[0] = game_get_speed(gamespeed_fps) * controlador_jogo.tempo_entre_inim_spawns* 3 // inimigos demoram 3 segundos pra aparecer no inicio do jogo
alarm[1] =  game_get_speed(gamespeed_fps) * controlador_jogo.tempo_entre_inim_spawns * 0.5