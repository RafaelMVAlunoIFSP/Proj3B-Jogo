/// Para numeros aleatórios

randomize()

// -- Constantes -- //

esperar_game_over = 2.5 // tempo ocioso até ir pra sala da game over
alarme_ativado = false // debounce para prevenir o alarme de ser ativado continuamente

// -- Variavéis globais --
global.player_dead_state = false
global.sala_atual = 0
global.jogo_pausado = false
global.vidas_restantes = 3

tempo_atual = get_timer()
telaMorte = false
jogoRecomecou = false

// --- Vidas --- //

scale_coracoes = 2.5 //quantas vezes preciso aumentar o sprite original ( ficar maior o coracao na gameplay)

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

//spawn_ultimo_inimigo = get_timer()
spawn_inimigo_permitido = false
tempo_entre_inim_spawns = 2.5 // 2.5 segundos

inimigo_simples_escala = 2.9375 // tamanho

INIMIGOS_DEFAULT_Y = 627


// -- FUNÇÕES -- //


function criar_ui_coracao(quantidade){
	var pos_x,pos_y = 0
	var layer_vidas = layer_get_id("Vidas")
	
	
	if not(layer_vidas) exit
	show_debug_message("TEM A CAMADA")
	show_debug_message(string(quantidade))
	
	
	for (c = 0;c < quantidade; c++){
		//show_debug_message("i: " + string(c)+ "; quantidade: " + string(quantidade))
		//show_debug_message("TA INDO")
		//show_debug_message(string(i))
		var vidas = layer_get_all_elements(layer_vidas)
		var quant_vidas = array_length(vidas)
		if quant_vidas >= 1 { // significa q a camada não ta vazia ( tem um instancia de coracao )
			show_debug_message("Gente tem corações")
			show_debug_message("Quant vidas : " + string(quant_vidas) + " Array: " + string(vidas))
			var ultimo_coracao = layer_instance_get_instance(vidas[0])
			if ultimo_coracao{
				var pos_x = (ultimo_coracao.x + ultimo_coracao.sprite_width / 2) + 50
				var pos_y = ultimo_coracao.y
			}
			
		}
		else{
			show_debug_message("Gente não achou coracoes")
			//show_debug_message(string(array_length(coracoes)))
			var layer_referencias = layer_get_id("Referencias")
			if layer_referencias{
				var referencias = layer_get_all_elements(layer_referencias)
				for (i = 0; i < array_length(referencias); i++)
				{	
					
					var element = layer_instance_get_instance(referencias[i])
					if element
					{
						if element.object_index == ref_spawn_coracao
						{
							var pos_x = element.x
							var pos_y = element.y
						}
					 }
				}
			}
		}
		novo_coracao = instance_create_layer(pos_x,pos_y,layer_vidas,obj_vida)
		novo_coracao.image_xscale = scale_coracoes
		novo_coracao.image_yscale = scale_coracoes
		//novo_coracao = instance_create_layer()
	}
}

function remover_ui_coracao(){
	var layer_vidas = layer_get_id("Vidas")
	if not(layer_vidas) exit
	var coracoes = layer_get_all_elements(layer_vidas)
	if array_length(coracoes) >= 1 {
		show_debug_message("Removendo coracao")
		show_debug_message(string(coracoes))
		
		instance_destroy(layer_instance_get_instance(coracoes[0])) // a posicao 0 corresponde à ultima instancia adicionada na camada (coração)
	}
}

// Atualizar relogio do jogo

function atualizar_clock(){
	tempo_atual = get_timer()
}



// Player Morreu 

function desenharTelaGameOver(){
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
		
		instance_destroy(inst)
	
		// MUDAR ISSO DEPOIS --> Destruir o inimigo e reespawnar ele

		
	}
	
}




function playerMorreu(){
	
	inst_60ADEB33.vspeed = 0 
	audio_stop_sound(level_music)
	var background_layer = layer_get_id("Background")
	layer_hspeed(background_layer,0)
	if !alarme_ativado {
		alarm[0] = game_get_speed(gamespeed_fps) * esperar_game_over
		alarme_ativado = true
	}
	show_debug_message(string(alarm))
	
	
	//show_debug_message("Player Morreu")
	

	if (keyboard_check_pressed(ord("R")))
	{	
		//show_debug_message("Apertou fii")
		// Resetando status do player
		controlador_cooldowns.alarm[0] = game_get_speed(gamespeed_fps) * 3 // resetar spawn de inimigos
		controlador_cooldowns.alarm[1] = game_get_speed(gamespeed_fps) * 0.5 // resetar lançamento de projetil
		
		var player = inst_60ADEB33 // mudar para uma função depois
		player.y = 683
		show_debug_message(player.y)
		global.player_dead_state = false
		//player.vivo = true
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
			var color = make_color_hsv(random(255), 255,200)
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

// Criando corações pro player
show_debug_message("Chamando criar coracao")
criar_ui_coracao(3)