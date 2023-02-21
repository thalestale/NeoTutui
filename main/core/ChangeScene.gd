extends Node

func HORIZONTAL(path : String) -> void:
	SceneManager.change_scene(path, 
		{ 
			"pattern" : "horizontal", 
			"ease" : 2.0, 
			"speed" : 2.0, 
			"wait_time" : 0.5, 
			"color" : Color("black")	
		})
	
	
	
