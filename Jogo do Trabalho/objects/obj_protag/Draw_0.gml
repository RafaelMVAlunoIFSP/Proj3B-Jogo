draw_self()

//draw_text(x,y-200,y)


if (keyboard_check_pressed(vk_space) && not(pulando))
	{	
		draw_text_transformed(x + 50, y - 150,"Pulando",0.2,0.2,0)
	}
	
	else{
		if abs( ( y - puloInitYPos )) > ALTURA_MAX_PULO{
			draw_text_transformed(x + 50, y - 150,"Caindo",0.2,0.2,0)
		}
		else{
			//show_debug_message( y - puloInitYPos)
		}
	}