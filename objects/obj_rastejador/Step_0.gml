
if self.vivo
{
	// Velocidade
	//show_debug_message("X: " + string(x) + "; Y: " + string(y))
	
	if inst_60ADEB33.vivo {
		x -= 5
		image_angle += irandom_range(3, 6)
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
	