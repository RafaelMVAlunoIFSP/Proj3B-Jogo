/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
draw_self()
draw_set_font(GameOverFont)
draw_set_halign(fa_right)
draw_set_valign(fa_bottom)


//conv_score(string(controlador_jogo.player_score)
// Score
draw_text_transformed(view_wport - 50, 100,conv_score(string(controlador_jogo.player_score)),0.3,0.3,0)

// Inimigos derrotados

draw_text_transformed(view_wport - 80, 150,"x" + string(controlador_jogo.inimigos_derrotados),0.3,0.3,0)

//Imagem inimigo
draw_sprite(spr_obstac,image_index,view_wport - 58, 127)