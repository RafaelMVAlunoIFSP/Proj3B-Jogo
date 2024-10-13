/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor



if inst_60ADEB33.vivo == false{

	vspeed = 0 
}
else
{	
	
	
	if (mouse_check_button_pressed(mb_left)) && (controlador_jogo.tempo_atual - ultimo_disparo) > tempo_entre_disparos
	{	
		ultimo_disparo = controlador_jogo.tempo_atual
		show_debug_message("Clicado")
		atirar_projetil()
	}
}

function pausar_projetil(){
	tempo_atual = get_timer()
	ultimo_disparo = get_timer - ultimo_disparo
}

function dispausar_projetil(){
	tempo_atual = get_timer()
	
}