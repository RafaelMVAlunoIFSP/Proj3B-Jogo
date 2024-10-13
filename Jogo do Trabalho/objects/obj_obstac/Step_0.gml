if self.vivo
{
	// Velocidade
	//show_debug_message("X: " + string(x) + "; Y: " + string(y))
	if global.player_dead_state == false{
		x -= 5
	}
	
	if (x + self.sprite_width/2) + 50 < view_xport //-  view_wport
	{	
		//show_debug_message("Distruindo!")
		instance_destroy(self)
	}
	

	// Loop do Meteoro



	// Reset
}

else 
{
	instance_destroy(self)
}
	
