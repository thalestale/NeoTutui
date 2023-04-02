extends Node


func DIALOGO(resource: Resource, title: String = "0", extra_game_states: Array = []) -> void:
	var JanelaDialogo = load("res://addons/dialogue_manager/example_balloon/small_example_balloon.tscn")
	
	var balloon: Node = JanelaDialogo.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, title, extra_game_states)
