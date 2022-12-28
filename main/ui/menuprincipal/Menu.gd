extends Control
var MouseFocus : bool

####################################################################################################

func _ready():
	Anima.FUNDO($Fundo)
	await SceneManager.transition_finished
	Mouse.ON()
	
	Anima.ABRE($Janela, "som")
	$Janela/Comecar.grab_focus()
	
	
####################################################################################################

	
####################################################################################################

func _on_button_mouse_entered(extra_arg_0: String) -> void:
	match extra_arg_0:
		"Comecar":
			Anima.Mouse()
			$Janela/Comecar.grab_focus()
		"Continuar":
			Anima.Mouse()
			$Janela/Continuar.grab_focus()
		"Opcoes":
			Anima.Mouse()
			$Janela/Opcoes.grab_focus()
		"Sair":
			Anima.Mouse()
			$Janela/Sair.grab_focus()

#---------------------------------------------------------------------------------------------------

func _on_button_mouse_exited(extra_arg_0: String) -> void:
	match extra_arg_0:
		"Comecar":
			Anima.NoMouse()
		"Continuar":
			Anima.NoMouse()
		"Opcoes":
			Anima.NoMouse()
		"Sair":
			Anima.NoMouse()

###################################################################################################

func _on_button_focus_entered(extra_arg_0: String) -> void:
	match extra_arg_0:
		"Comecar":
			Anima.BUTTON_FOCUS($Janela/Comecar)
		"Continuar":
			Anima.BUTTON_FOCUS($Janela/Continuar)
		"Opcoes":
			Anima.BUTTON_FOCUS($Janela/Opcoes)
		"Sair":
			Anima.BUTTON_FOCUS($Janela/Sair)
	
	Som.CLICK()

#---------------------------------------------------------------------------------------------------

func _on_button_focus_exited(extra_arg_0: String) -> void:
	match extra_arg_0:
		"Comecar":
			Anima.BUTTON_UNFOCUS($Janela/Comecar)
		"Continuar":
			Anima.BUTTON_UNFOCUS($Janela/Continuar)
		"Opcoes":
			Anima.BUTTON_UNFOCUS($Janela/Opcoes)
		"Sair":
			Anima.BUTTON_UNFOCUS($Janela/Sair)

###################################################################################################




func _on_comecar_pressed() -> void:
	Som.OK()
	Change.HORIZONTAL("res://ui/menuprincipal/EntraNome/EntraNome.tscn")


func _on_continuar_pressed() -> void:
	pass # Replace with function body.


func _on_opcoes_pressed() -> void:
	Som.OK()
	Change.HORIZONTAL("res://ui/menuprincipal/Opcoes/Opcoes.tscn")


func _on_sair_pressed() -> void:
	Anima.FECHA($Janela, "som")
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
