/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if self.vivo
{
	// Velocidade
	//show_debug_message("X: " + string(x) + "; Y: " + string(y))
	
	if global.player_dead_state == false {
		x -= 5
	}

	// Loop do Meteoro

	if (x + self.sprite_width/2) + 50 < view_xport //-  view_wport
	{	
		show_debug_message("Distruindo!")
		instance_destroy(self)
	}

	// Reset
}

else 
{
	instance_destroy(self)
}
	