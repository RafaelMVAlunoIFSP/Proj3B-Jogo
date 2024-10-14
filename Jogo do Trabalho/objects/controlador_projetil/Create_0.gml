        /// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

tempo_entre_disparos = 0.5 // 0.5 segundo
ultimo_disparo = get_timer()
pode_disparar = false
//projeteis = []



function atirar_projetil(){
	audio_play_sound(som_projetil,1,false)
	instance_create_layer(inst_60ADEB33.x + 32, inst_60ADEB33.y - 80, "Projeteis", projetil_player)
	//array_push(projeteis,_projetil)
}

function parar_projetil(){
	hspeed = 0
}


function deletar_projetil(){
	
	instance_destroy(self)
}


function deletar_projeteis(){
	
	
	var projeteis_layer_id = layer_get_id("Projeteis")
	var projeteis = layer_get_all_elements(projeteis_layer_id)
	
	show_debug_message("Instancias na camada: " + string(projeteis))
	for (i = 0; i < array_length(projeteis); i++;)
	{
		var inst = layer_instance_get_instance(projeteis[i])

		//destroi os projeteis
		instance_destroy(inst)
		
	}
	
}