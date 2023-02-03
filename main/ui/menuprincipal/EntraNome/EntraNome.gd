extends Control


func _ready() -> void:
	Mouse.OFF()
	Anima.FUNDO($Fundo)
	await SceneManager.transition_finished
	await get_tree().create_timer(0.2).timeout
	Anima.ABRE($Janela, "som")
	
	await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_tween().tween_property($Janela/Label, "visible_ratio", 
	1.0, 1.0).finished
	
	await get_tree().create_tween().tween_property($Janela/Label, "position", 
	Vector2(112.5, 45.0), 0.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).finished
	
	await get_tree().create_timer(0.5).timeout
	Anima.ABRE($Janela/LineEdit, "mute")
	$Janela/LineEdit.grab_focus()
	
	


func _on_line_edit_text_changed(_new_text: String) -> void:
	Som.CLICK()
	if $Janela/LineEdit.text.length() < 2:
		$Janela/TeclaEnter.visible = false
	else:
		$Janela/TeclaEnter.visible = true


func _on_line_edit_text_submitted(new_text: String) -> void:
	Som.OK()
	Data.NomePlayer = new_text
	Change.HORIZONTAL("res://cenas/Testes/escada.tscn")
	
