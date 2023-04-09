extends Control

func _ready() -> void:
	Mouse.OFF()
	await get_tree().create_timer(0.1).timeout
	SceneManager.change_scene('res://ui/menuprincipal/Menu.tscn', 
			{"pattern_leave" : "circle", 
			"pattern_enter" : "fade", 
			"ease" : 4.0, 
			"color" : Color('#FFFFFF'),
			"speed" : 0.7})
			
	
	
