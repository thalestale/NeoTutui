extends Control
var mousepos
var mousepos2

func _process(delta):
	mousepos2 = get_global_mouse_position()
	


func _input(event):
	if InputEventMouseMotion:
		mousepos = get_global_mouse_position()
		if mousepos == mousepos2:
			await get_tree().create_timer(0.2).timeout
			set_process_input(false)
			await get_tree().create_timer(0.2).timeout
			set_process_input(true)
			
		else:
			$MouseCursor.position = mousepos
	
