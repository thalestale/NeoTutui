extends Control



func _ready():
	await get_tree().create_timer(1.0).timeout
	
	get_node("/root/Anima").ABRE($Janela, "som")
	
	await get_tree().create_timer(1.0).timeout
	
	get_node("/root/Anima").FECHA($Janela, "som")
