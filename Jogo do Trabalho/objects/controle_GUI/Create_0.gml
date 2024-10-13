/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Converte o score do player (já em string) para ficar adequado ao estilo do score
score_zeros = string_length("0000000")

function conv_score(_score ){ // supõe que o score já esta em string
	
	
	var score_string_lenght = string_length(_score)
	
	if score_string_lenght > score_zeros{
		return _score
	}
	
	else
	{
		return ((score_zeros - score_string_lenght) * "0") + _score
	}
}

