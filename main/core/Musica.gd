extends Node

var NodeMusica : Node
var MusicaAnterior : Node
var MusicaAnteriorString : String

func Tocar(musica : String, transicao : float) -> void:
	#baixa o volume da musica que tava tocando antes
	if MusicaAnterior == $Luneta:
		MusicaAnteriorString = "LUNETA"
	elif MusicaAnterior == $Rose:
		MusicaAnteriorString = "ROSE"
	else:
		pass
		
	if musica == MusicaAnteriorString or MusicaAnteriorString == "":
		pass
	else:
		NodeMusica = MusicaAnterior
		DesligaMusicaAnterior(transicao)
	
	#associa o argumento ao node ----------------------------------------------
	match musica:
		"LUNETA":
			NodeMusica = $Luneta
		"ROSE":
			NodeMusica = $Rose
		
	#comeca a tocar a musica --------------------------------------------------
	NodeMusica.volume_db = -80.0 #volume minimo antes de tocar
	NodeMusica.play()
	get_tree().create_tween().tween_property(NodeMusica, "volume_db", 0.0, transicao)
	

func DesligaMusicaAnterior(transicao : float) -> void:
	if NodeMusica:
		
		await get_tree().create_tween().tween_property(NodeMusica, "volume_db", -80.0, transicao).fin
		MusicaAnterior.playing = false
	
