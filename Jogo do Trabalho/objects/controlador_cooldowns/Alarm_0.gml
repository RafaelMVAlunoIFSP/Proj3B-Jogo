/// @description Cooldown - spawn inimigos simples
// Você pode escrever seu código neste editor

show_debug_message("Spawnando inimigo...")
controlador_jogo.spawn_inimigo_permitido = true
alarm[0] = game_get_speed(gamespeed_fps) * controlador_jogo.tempo_entre_inim_spawns
