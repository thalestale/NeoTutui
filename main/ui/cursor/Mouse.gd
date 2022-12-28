extends Control
var mousepos = Vector2()
var mousepos2 = Vector2()

func _ready() -> void:
	$MouseCursor/AnimationPlayer.play("mouseani")

func _process(_delta: float) -> void:
	mousepos2 = get_global_mouse_position()
	
func ON() -> void:
	$MouseCursor.visible = true
	set_process_input(true)
	set_process(true)
	
func OFF() -> void:
	$MouseCursor.visible = false
	set_process_input(false)
	set_process(false)
	


func _input(_event) -> void:
	if InputEventMouseMotion:
		mousepos = get_global_mouse_position()
		if mousepos == mousepos2:
			pass
			
		else:
			$MouseCursor.position = mousepos
	
