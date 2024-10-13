/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (x >= -120 and x <= -100)
	{	
		instance_destroy(self)
	}
else{
	if global.player_dead_state == false {
		x += 9
	}

}