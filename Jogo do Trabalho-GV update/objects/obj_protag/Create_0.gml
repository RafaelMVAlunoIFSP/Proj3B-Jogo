vivo = true
pulando = false
tocandoChao = true
vidas = 3


audio_play_sound(level_music,0,true)

ALTURA_MAX_PULO = 10
puloInitYPos = y // Segurar posição do player (cheque de altura


function handlePulo(){
	
	
	if (keyboard_check_pressed(vk_space) && not(pulando))
	{	
		pulando = true
		puloInitYPos = y
		vspeed -= 9
	}
	
	else{
		
		if abs( ( y - puloInitYPos )) > ALTURA_MAX_PULO{
			vspeed += 0.25
		}
	
	}

}