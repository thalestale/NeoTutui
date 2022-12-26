extends Node

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _input(_event) -> void:
	if Input.is_action_just_released("panic"):
		get_tree().quit()
