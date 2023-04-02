extends Control

var resource = load("res://cenas/Testes/dialogo.dialogue")
var title : String = "abc"
var playercogu : bool = false

func _ready() -> void:
	MUSICA.Tocar("ROSE", 1.5)
	get_tree().create_tween().tween_property($ParallaxBackground/ColorRect2, "texture:noise:fractal_lacunarity", 3.00, 20.00)

func _input(_event) -> void:
	if Input.is_action_just_pressed("ui_accept") and playercogu:
		set_process_input(false)
		Dialogo.DIALOGO(resource, title)
		await DialogueManager.dialogue_ended
		set_process_input(true)


func _on_area_3d_body_entered(body) -> void:
	if body == $SubViewportContainer/SubViewport/Cena/Player:
		playercogu =  true


func _on_area_3d_body_exited(body) -> void:
	if body == $SubViewportContainer/SubViewport/Cena/Player:
		playercogu = false
