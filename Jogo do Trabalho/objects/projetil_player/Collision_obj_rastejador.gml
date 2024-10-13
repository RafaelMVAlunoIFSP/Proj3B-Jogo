/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//if !desativado{
	desativado = true
	controlador_jogo.inimigos_derrotados += 1
	audio_play_sound(som_hit_inimigo,1,false)
	instance_destroy(self)
	other.vivo = false 
	//self
//}