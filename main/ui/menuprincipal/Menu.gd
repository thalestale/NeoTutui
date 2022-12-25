extends Control



func _ready():
	await get_tree().create_timer(1.0).timeout
	
	get_node("/root/Anima").ABRE($Janela, "som")
	
	await get_tree().create_timer(1.0).timeout
	
	#get_node("/root/Anima").FECHA($Janela, "som")

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_node("/root/Mouse/MouseCursor").position = Vector2(400, 400)
	


func _on_button_mouse_entered() -> void:
	get_tree().create_tween().tween_property($Janela/Button, "scale", Vector2(1.01, 1.01), 
	0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	get_tree().create_tween().tween_property($Janela/Button, "modulate", Color(1, 0.95, 1, 1), 
	0.05).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()

func _on_button_mouse_exited() -> void:
	get_tree().create_tween().tween_property($Janela/Button, "scale", Vector2(1.0, 1.0), 
	0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
	
	get_tree().create_tween().tween_property($Janela/Button, "modulate", Color(1, 1, 1, 1), 
	0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from_current()
