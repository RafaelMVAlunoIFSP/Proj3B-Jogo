/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// atualizar tempo




// Player morreu
if inst_60ADEB33.vivo == false{
	playerMorreu()
	
}
else{
	//show_debug_message("TEMPO ATUAL: " + string( tempo_atual))
	//show_debug_message("TEMPO ULTIMO DISPARO: " + string(controlador_projetil.ultimo_disparo))
	// Pausar jogo
	 if keyboard_check_pressed(ord("P")){
		//show_debug_message("Usuário pausou")
		jogoPausadoHandler()
	}
	
	else{
		atualizar_clock() // atualizar o tempo do jogo ( para cooldowns, etc)
		// -- Score -- //
		aumentarScorePlayer(1,"Etapa")
	
		// -- Spawn Inimigos -- //
		if (get_timer() - spawn_ultimo_inimigo ) > tempo_entre_inim_spawns 
		{
			spawn_ultimo_inimigo = get_timer()
			//show_debug_message("Spawnando inimigo!")
			var inim_aleatorio = selec_inimigo_aleatorio()
			//show_debug_message("Inim aleatorio: " + object_get_name(objetos_inimigos[$ inim_aleatorio]._obj))
			spawnar_inimigo(inim_aleatorio, "automatico", "automatico",false,true)
		}
	}
	
	
}


// Spawn de Inimigos SIMPLES

// Score


