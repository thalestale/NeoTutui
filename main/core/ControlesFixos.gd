extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _input(_event):
	if Input.is_action_just_released("panic"):
		get_tree().quit()
