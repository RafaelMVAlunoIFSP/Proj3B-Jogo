/// Para numeros aleatórios

randomize()

alarm[0] = game_get_speed(gamespeed_fps) * 5
// Variaveis para controle do pause do jogo

tempo_atual = get_timer()
jogoPausado = false
superficieId = -1 //Pra fazer a tela de pause, a gente vai precisar usar uma superficie
telaMorte = false
jogoRecomecou = false

// --- ESTATISTICAS PLAYER ---- //

player_score = 0
inimigos_derrotados = 0

ultimo_score_dado = get_timer()
tempo_debounce_score = 100000 // em microsegundos == 

// --- INIMIGOS ---- 


objetos_inimigos = {
	inimigo_simples : {
		_obj : obj_obstac,
		_scale : 2.983
	},
	inimigo_desviar : {
		_obj: obj_rastejador,
		_scale:2.983
	}
}

tipos_inimigos =[ "inimigo_simples", "inimigo_desviar"]

spawn_ultimo_inimigo = get_timer()
tempo_entre_inim_spawns = 5000000 // 5 segundos

inimigo_simples_escala = 2.9375 // tamanho

INIMIGOS_DEFAULT_Y = 627


// Atualizar relogio do jogo

function atualizar_clock(){
	tempo_atual = get_timer()
}

// Pausar //
function jogoPausadoHandler(){
	controlador_jogo.jogoPausado = !jogoPausado
	
	if not(controlador_jogo.jogoPausado){
		instance_activate_all()
		surface_free(superficieId)
		superficieId = -1
		controlador_projetil.ultimo_disparo = tempo_atual - controlador_projetil.ultimo_disparo
		show_debug_message( "Despausando timer: " + string(controlador_projetil.ultimo_disparo))
	}
	else {
		controlador_projetil.ultimo_disparo = tempo_atual - controlador_projetil.ultimo_disparo
		show_debug_message( "Pausando timer: " + string(controlador_projetil.ultimo_disparo))
		// Talvez seja util depois
	}
}

// desenho do menu e detecção da mudança da var jogoPausado
function desenharPausaMenu(){ 
	
	
		if (controlador_jogo.jogoPausado && inst_60ADEB33.vivo)
		{
			if !surface_exists(superficieId) // se a superficie não existir, a gente cria uma ( as vezes retorna false se o jogo tiver minimazado, por isso checamos abaixo o id da superficie )
			{ 
				if superficieId == -1 // signfica q a gente pode ir para o estado pausado (-1 = superficie ja foi limpada desde o ultimo pause )
				{
					instance_deactivate_all(true) // desativar todas as instancias na sala ( exceto a controlador_jogo obviamente )
				}
				
				controlador_jogo.superficieId = surface_create(room_width, room_height) // inicializa a superficie com o tamanho da nossa sala
				surface_set_target(controlador_jogo.superficieId) // todos os "desenhos" vão passar a ser feitos nessa superficie
				draw_surface(application_surface,0,0) // desenha na superficie a application surface ( o que ta sendo desenhado no momento )
				surface_reset_target() // Permite que a gente faça novos desenhos nessa superficie ( ver documentação )
			}
			else{
				draw_surface(controlador_jogo.superficieId, 0, 0);
				draw_set_alpha(0.5);
				draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
				draw_set_alpha(1);
				draw_set_halign(fa_center);
				draw_set_font(MenuFont)
				draw_text_transformed_colour(view_wport / 2, view_hport / 2, "JOGO PAUSADO", 1, 1, 0, c_aqua, c_aqua, c_aqua, c_aqua, 1);
				draw_set_halign(fa_left);
			}
		}
	
	
}


// Player Morreu 


function desenharTelaGameOver(){
	show_debug_message("GAME OVER")
	draw_set_font(GameOverFont)
	draw_set_halign(fa_center)
	draw_text_transformed(view_wport / 2, (view_hport / 2) - 100,"GAME OVER",0.5,0.5,0)
}


function resetInimigos(){

	var inimigos_layer_id = layer_get_id("Inimigos")
	var inimigos = layer_get_all_elements(inimigos_layer_id)
	
	show_debug_message("Instances in layer: " + string(inimigos))
	
	for (i = 0; i < array_length(inimigos); i++;)
	{
		var inst = layer_instance_get_instance(inimigos[i])
		show_debug_message(string(inst))
		if layer_get_element_type(inimigos[i]) != layerelementtype_instance{
			show_debug_message("É diferente")
			continue
		}
	
		// MUDAR ISSO DEPOIS --> Destruir o inimigo e reespawnar ele
		inst.x = 1450
		inst.vivo = true
		inst.tocouPlayer = false
		
	}
	
}




function playerMorreu(){
	
	inst_60ADEB33.vspeed = 0 
	audio_stop_sound(level_music)
	//show_debug_message("Player Morreu")
	

	if (keyboard_check_pressed(ord("R")))
	{	
		//show_debug_message("Apertou fii")
		// Resetando status do player
		var player = inst_60ADEB33 // mudar para uma função depois
		player.y = 683
		player.vivo = true
		player.pulando = false
		player_score = 0 // Resetando score do player
		inimigos_derrotados = 0
		// Resetando inimigos
		controlador_projetil.deletar_projeteis()
		resetInimigos()
		audio_play_sound(level_music,0,true)
	}
}

function aumentarScorePlayer(quantidade,tipo){
	if tipo == "Etapa"{ // incremento acontece continuamente, portanto usamos um debounce
		if (get_timer() - ultimo_score_dado) >= tempo_debounce_score{
			player_score += quantidade
			ultimo_score_dado = get_timer()
		}
	}
	else{
		player_score += quantidade
	}
}

function spawnar_inimigo(tipo_inimigo, pos_x, pos_y, _sprite_color, _random_color){
	
	if (_sprite_color == undefined) _sprite_color = false
	if (_random_color == undefined) _random_color = false
	
	var inimigo = objetos_inimigos[$ tipo_inimigo]


	if inimigo {
		
		var inimigo_obj = objetos_inimigos[$ tipo_inimigo]._obj
		//show_debug_message(string(inimigo_obj))
		var _scale = inimigo._scale
		if pos_x == "automatico"{
			pos_x = view_wport + sprite_get_width( object_get_sprite(inimigo_obj)) * _scale
		}
		
		if pos_y == "automatico"{
			pos_y = INIMIGOS_DEFAULT_Y
		}
		
		//show_debug_message("ACHO O INIMIGO" + object_get_name(inimigo_obj))
		var clone_obj = instance_create_layer(pos_x,pos_y,"Inimigos",inimigo_obj)
		clone_obj.image_xscale = _scale
		clone_obj.image_yscale = _scale
		clone_obj.y = pos_y
		//show_debug_message("Clone at y: " + string(clone_obj.y))
		if _sprite_color{
			clone_obj.image_blend = _sprite_color
		}
		if _random_color{
			var color = make_color_hsv(random(2), 255,200)
			clone_obj.image_blend = color
		}
	}
	else{
		show_debug_message("Num tem")
	}
	
}

function selec_inimigo_aleatorio(){
	var quant_inimigos = array_length(tipos_inimigos)
	var n_aleatorio = irandom(quant_inimigos -1)
	//show_debug_message(string("Inimigo tipo: " + string(n_aleatorio)))
	return  tipos_inimigos[n_aleatorio]
}