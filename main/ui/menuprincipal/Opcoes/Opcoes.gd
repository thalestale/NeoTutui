extends Control
var VolumeUI : float
var VolumeMusica : float

###########################################################################

func _ready() -> void:
	
	# Verifica o estado atual das config ___________________
	VolumeUI = Data.VolumeUI
	VolumeMusica = Data.VolumeMusica
	
	if DisplayServer.window_get_mode() == 4:
		$Janela/TelaCheia.button_pressed = true
	else:
		$Janela/TelaCheia.button_pressed = false
	
	#_______________________________________________________
	
	Anima.FUNDO($Fundo)
	$Janela/BtVoltar.grab_focus()

#############################################################################
#===========================================================================
# SONS

func _on_sons_value_changed(value: float) -> void:
	VolumeUI = 100 - value
	VolumeUI = VolumeUI * 0.35
	VolumeUI = VolumeUI * -1
	AudioServer.set_bus_volume_db(1, VolumeUI)

	if value == 0:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	Som.CLICK()
	
func _on_bt_up_sons_pressed() -> void:
	$Janela/Sons.value += 5

func _on_bt_down_sons_pressed() -> void:
	$Janela/Sons.value += -5

#-=====================================================================
# MUSICA

func _on_musica_value_changed(value: float) -> void:
	VolumeMusica = 100 - value
	VolumeMusica = VolumeMusica * 0.35
	VolumeMusica = VolumeMusica * -1
	AudioServer.set_bus_volume_db(2, VolumeMusica)

	if value == 0:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
	Som.CLICK()
	
func _on_bt_up_mus_pressed() -> void:
	$Janela/Musica.value += 5

func _on_bt_down_mus_pressed() -> void:
	$Janela/Musica.value += -5
	
#---------- Focus Sons ---------------------
	
func _on_bt_up_sons_focus_entered() -> void:
	pass

func _on_bt_up_sons_focus_exited() -> void:
	pass

func _on_bt_up_sons_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/Sons/BtUpSons.grab_focus()

func _on_bt_up_sons_mouse_exited() -> void:
	Anima.NoMouse()

func _on_bt_down_sons_focus_entered() -> void:
	#Anima.BUTTON_FOCUS($Janela/Sons/BtDownSons)
	pass

func _on_bt_down_sons_focus_exited() -> void:
	#Anima.BUTTON_UNFOCUS($Janela/Sons/BtDownSons)
	pass

func _on_bt_down_sons_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/Sons/BtDownSons.grab_focus()

func _on_bt_down_sons_mouse_exited() -> void:
	Anima.NoMouse()
	
#------------- Focus Musica -------------------

func _on_bt_up_mus_focus_entered() -> void:
	#Anima.BUTTON_FOCUS($Janela/Musica/BtUpMus)
	pass

func _on_bt_up_mus_focus_exited() -> void:
	#Anima.BUTTON_UNFOCUS($Janela/Musica/BtUpMus)
	pass

func _on_bt_up_mus_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/Musica/BtUpMus.grab_focus()

func _on_bt_up_mus_mouse_exited() -> void:
	Anima.NoMouse()

func _on_bt_down_mus_focus_entered() -> void:
	#Anima.BUTTON_FOCUS($Janela/Musica/BtDownMus)
	pass

func _on_bt_down_mus_focus_exited() -> void:
	#Anima.BUTTON_UNFOCUS($Janela/Musica/BtDownMus)
	pass

func _on_bt_down_mus_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/Musica/BtDownMus.grab_focus()

func _on_bt_down_mus_mouse_exited() -> void:
	Anima.NoMouse()
	
	
##########################################################################
#=========================================================================
# VOLTAR

func _on_bt_voltar_pressed() -> void:
	Change.HORIZONTAL("res://ui/menuprincipal/Menu.tscn")

func _on_bt_voltar_focus_entered() -> void:
	Anima.BUTTON_FOCUS($Janela/BtVoltar)

func _on_bt_voltar_focus_exited() -> void:
	Anima.BUTTON_UNFOCUS($Janela/BtVoltar)

func _on_bt_voltar_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/BtVoltar.grab_focus()

func _on_bt_voltar_mouse_exited() -> void:
	Anima.NoMouse()
	
#=========================================================================
# TELA CHEIA

func _on_tela_cheia_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_tela_cheia_focus_entered() -> void:
	Anima.BUTTON_FOCUS($Janela/TelaCheia)

func _on_tela_cheia_focus_exited() -> void:
	Anima.BUTTON_UNFOCUS($Janela/TelaCheia)

func _on_tela_cheia_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/TelaCheia.grab_focus()

func _on_tela_cheia_mouse_exited() -> void:
	Anima.NoMouse()

#==========================================================================


func _on_graficos_toggled(button_pressed: bool) -> void:
	pass # Replace with function body.


func _on_graficos_focus_entered() -> void:
	Anima.BUTTON_FOCUS($Janela/Graficos)


func _on_graficos_focus_exited() -> void:
	Anima.BUTTON_UNFOCUS($Janela/Graficos)


func _on_graficos_mouse_entered() -> void:
	Anima.Mouse()
	$Janela/Graficos.grab_focus()


func _on_graficos_mouse_exited() -> void:
	Anima.NoMouse()
