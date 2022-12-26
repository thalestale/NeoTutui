extends Node

#---------------------------------------------------------------------------------------------------
func CURSOR_MOVE(alvo: Object) -> void:
	get_tree().create_tween().tween_property(get_node("/root/Mouse/MouseCursor") , 
	"position", 
	alvo.global_position, 
	0.1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).from_current()
	
	
#---------------------------------------------------------------------------------------------------
func ABRE(alvo: Object, argumento: String) -> void: #abre janela
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 1, 1, 1), 
	0.3).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 0))
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.0 , 1.0), 
	0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT).from(Vector2(0.97, 0.0)).finished
	
	if argumento == "mute":
		pass
	else:
		Som.PICK()
		
#---------------------------------------------------------------------------------------------------
func FECHA(alvo: Object, argumento: String) -> void: #fecha janela
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 1, 0, 0), 
	0.5).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 1))
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.0, 0.01),
	0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
	if argumento == "mute":
		pass
	else:
		Som.VOLTA()
	
	await get_tree().create_tween().tween_property(alvo, "scale", Vector2(0.0, 0.01),
	0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
	
######################################  BOTOES  ####################################################
#---------------------------------------------------------------------------------------------------
func BUTTON_FOCUS(alvo: Object) -> void:
	get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.005, 1.005), 
	0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 0.95, 1, 1), 
	0.05).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
#---------------------------------------------------------------------------------------------------
func BUTTON_UNFOCUS(alvo: Object) -> void:
	get_tree().create_tween().tween_property(alvo, "scale", Vector2(1.0, 1.0), 
	0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	get_tree().create_tween().tween_property(alvo, "modulate", Color(1, 1, 1, 1), 
	0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	
