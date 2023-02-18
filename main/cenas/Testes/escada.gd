extends Node3D

var resource = load("res://cenas/Testes/dialogo.dialogue")
var title : String = "abc"
var playercogu : bool = false

func _ready() -> void:
	MUSICA.Tocar("LUNETA", 1.0)

func _input(_event) -> void:
	if Input.is_action_just_pressed("ui_accept") and playercogu:
		set_process_input(false)
		Dialogo.DIALOGO(resource, title)
		await DialogueManager.dialogue_finished
		set_process_input(true)

func _on_area_3d_body_entered(body) -> void:
	if body == $Player:
		playercogu =  true


func _on_area_3d_body_exited(body) -> void:
	if body == $Player:
		playercogu = false
		
