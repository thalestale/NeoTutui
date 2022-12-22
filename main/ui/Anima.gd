extends Node

#---------------------------------------------------------------------------------------------------
func ABRE(alvo, argumento): #abre janela
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 1, 1, 1), 
	0.3).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 0))
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.0 , 1.0), 
	0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT).from(Vector2(0.97, 0.0)).finished
	
	if argumento == "mute":
		pass
	else:
		get_node("/root/Som").CLICK()
		
#---------------------------------------------------------------------------------------------------
func FECHA(alvo, argumento): #fecha janela
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 1, 0, 0), 
	0.5).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 1))
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.0, 0.01),
	0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
	if argumento == "mute":
		pass
	else:
		get_node("/root/Som").VOLTA()
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(0.0, 0.01),
	0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
#---------------------------------------------------------------------------------------------------
	
	
