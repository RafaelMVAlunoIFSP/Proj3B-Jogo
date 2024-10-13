/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
// Pausar //

superficie_id = -1 //Pra fazer a tela de pause, a gente vai precisar usar uma superficie
nao_desativar = {
	cont_cooldown: controlador_cooldowns
}

function jogoPausadoHandler(){
	global.jogo_pausado = !global.jogo_pausado
	
	if not(global.jogo_pausado) && global.player_dead_state == false{
		instance_activate_all()
		surface_free(superficie_id)
		instance_deactivate_object(inst_88268D2)
		superficie_id = -1
		//controlador_projetil.ultimo_disparo = tempo_atual - controlador_projetil.ultimo_disparo
		show_debug_message( "Despausando timer: " + string(controlador_projetil.ultimo_disparo))
	}
	else {
		//controlador_projetil.ultimo_disparo = tempo_atual - controlador_projetil.ultimo_disparo
		show_debug_message( "Pausando timer: " + string(controlador_projetil.ultimo_disparo))
		// Talvez seja util depois
	}
}

// desenho do menu e detecção da mudança da var jogoPausado
function desenharPausaMenu(){ 
	
		
		if (global.jogo_pausado && global.player_dead_state == false)
		{	
			//alarm[0] ++
			if !surface_exists(superficie_id) // se a superficie não existir, a gente cria uma ( as vezes retorna false se o jogo tiver minimazado, por isso checamos abaixo o id da superficie )
			{ 
				if superficie_id == -1 // signfica q a gente pode ir para o estado pausado (-1 = superficie ja foi limpada desde o ultimo pause )
				{	
					
					instance_deactivate_all(true) // desativar todas as instancias na sala ( exceto a controlador_jogo obviamente )
				}
				
				superficie_id = surface_create(room_width, room_height) // inicializa a superficie com o tamanho da nossa sala
				surface_set_target(superficie_id) // todos os "desenhos" vão passar a ser feitos nessa superficie
				draw_surface(application_surface,0,0) // desenha na superficie a application surface ( o que ta sendo desenhado no momento )
				surface_reset_target() // Permite que a gente faça novos desenhos nessa superficie ( ver documentação )
			}
			else{
				
				draw_surface(superficie_id, 0, 0);
				draw_set_alpha(0.5);
				draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
				draw_set_alpha(1);
				draw_set_halign(fa_center);
				draw_set_font(MenuFont)
				draw_text_transformed_colour(view_wport / 2, view_hport / 2, "JOGO PAUSADO", 1, 1, 0, c_aqua, c_aqua, c_aqua, c_aqua, 1);
				
				instance_activate_object(voltar_menu)
				if instance_exists(inst_88268D2) { // botão de voltar ao menu
					draw_set_font(GameOverFont)
					draw_set_halign(fa_center)
					draw_set_valign(fa_middle)
					
					inst_88268D2.x = view_wport / 2 
					inst_88268D2.y = view_hport / 2 
					draw_text_transformed(inst_88268D2.x/2,inst_88268D2.y/2,"Voltar ao Menu", 0.2,0.2,0)
					show_debug_message("EXISTE SIM FDPSPDPAPDA")

				}
				else{
					show_debug_message("NAO EXISTE VIADOO")
				}

				draw_set_halign(fa_left);
			}
		}
	
	
}