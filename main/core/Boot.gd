extends Control

func _ready() -> void:
	Mouse.OFF()
	await get_tree().create_timer(0.2).timeout
	SceneManager.change_scene('res://ui/menuprincipal/Menu.tscn', 
			{"pattern_leave" : "circle", 
			"pattern_enter" : "fade", 
			"ease" : 2.0, 
			"speed" : 2.0})
