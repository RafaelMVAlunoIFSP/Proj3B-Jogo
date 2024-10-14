vivo = true
tocouPlayer = false


// Vidas

function perderVida(){
	if inst_60ADEB33.vidas == 3{
		instance_destroy(inst_1D6FE3FF)
		instance_destroy(self)
		inst_60ADEB33.vidas = inst_60ADEB33.vidas - 1
		somDano()
	}
	
	else if inst_60ADEB33.vidas == 2{
		instance_destroy(inst_67B85C96)
		instance_destroy(self)
		inst_60ADEB33.vidas = inst_60ADEB33.vidas - 1
		somDano()
	}
	
	else if inst_60ADEB33.vidas == 1{
		instance_destroy(inst_75382359)
		instance_destroy(self)
		inst_60ADEB33.vidas = inst_60ADEB33.vidas - 1
		somDano()
	}
	
}

// Som de Dano

function somDano(){
	choice = irandom_range(1,4)
	
	if choice == 1{
		audio_play_sound(dano1,1,false)
	}
	
	if choice == 2{
		audio_play_sound(dano2,1,false)
	}
	
	if choice == 3{
		audio_play_sound(dano3,1,false)
	}
	
	if choice == 4{
		audio_play_sound(dano4,1,false)
	}
}