extends Node
var MouseFocused : bool

#---------------------------------------------------------------------------------------------------
func CURSOR_MOVE(alvo: Object) -> void:
	get_tree().create_tween().tween_property(get_node("/root/Mouse/MouseCursor") , 
			"position", 
			alvo.global_position, 
			0.1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).from_current()
	
func NoMouse() -> void:
	MouseFocused = false

func Mouse() -> void:
	MouseFocused = true
	
	
#---------------------------------------------------------------------------------------------------
func ABRE(alvo: Object, argumento: String) -> void: #abre janela
	
	get_tree().create_tween().set_parallel().tween_property(alvo, 
			"modulate", 
			Color(1, 1, 1, 1), 
			0.15).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 0))
	
	await get_tree().create_tween().tween_property(alvo, 
			"scale", 
			Vector2(1.0 , 1.0), 
			0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT).from(Vector2(0.97, 0.0)).finished
	
	if argumento == "mute":
		pass
	else:
		Som.PICK()
		
#---------------------------------------------------------------------------------------------------
func FECHA(alvo: Object, argumento: String) -> void: #fecha janela
	
	get_tree().create_tween().tween_property(alvo, 
			"modulate", 
			Color(1, 1, 0, 0), 
			0.5).set_trans(Tween.TRANS_CIRC).from(Color(1, 1, 1, 1))
	
	await get_tree().create_tween().tween_property(alvo, 
			"scale", 
			Vector2(1.0, 0.01),
			0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
	if argumento == "mute":
		pass
	else:
		Som.VOLTA()
	
	await get_tree().create_tween().tween_property(alvo, 
			"scale", 
			Vector2(0.0, 0.01),
			0.15).set_trans(Tween.TRANS_BACK).from_current().finished
	
#---------------------------------------------------------------------------------------------------
func FUNDO(alvo : Object) -> void:
	get_tree().create_tween().set_loops().set_parallel().tween_property(alvo, 
			"position", 
			Vector2(-350, -350),
			20.0).set_trans(Tween.TRANS_LINEAR).from(Vector2(0, 0))
	
	
######################################  BOTOES  ####################################################
#---------------------------------------------------------------------------------------------------
func BUTTON_FOCUS(alvo: Object) -> void:
	get_tree().create_tween().set_parallel().tween_property(alvo, 
			"scale", 
			Vector2(1.005, 1.005), 
			0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	if not MouseFocused:
		get_tree().create_tween().set_parallel().tween_property(get_node("/root/Mouse/MouseCursor"), 
				"position", 
				alvo.pivot_offset + alvo.global_position, 
				0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	get_tree().create_tween().set_parallel().tween_property(alvo, 
			"modulate", 
			Color(1, 0.95, 1, 1), 
			0.05).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	NoMouse()
	
#---------------------------------------------------------------------------------------------------
func BUTTON_UNFOCUS(alvo: Object) -> void:
	get_tree().create_tween().tween_property(alvo, 
			"scale", 
			Vector2(1.0, 1.0), 
			0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	get_tree().create_tween().tween_property(alvo, 
			"modulate", 
			Color(1, 1, 1, 1), 
			0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	
