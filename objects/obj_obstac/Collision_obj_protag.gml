

if not(tocouPlayer) {
	tocouPlayer = true
	//hspeed += 0
	perderVida()
	if inst_60ADEB33.vidas == 0{
		inst_60ADEB33.vivo = false
	}
	//vivo = false
	//draw_text_transformed(480,200,"GAME OVER",0.5,0.5,0)
	//show_debug_message("Tocou player no tempo: {}, get_timer()")
}
else{
	//tocouPlayer = true
}




//show_debug_message(string("Tocou player no tempo: {0}", get_timer()))
