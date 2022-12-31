extends Node

# CONFIG GERAIS DO JOGO
var VolumeUI : float = 80
var VolumeMusica : float = 80

# DADOS DO PLAYER
var NomePlayer : String

###############################################################################
#==========================================================================

func save():
	var save_dict = {
		"NomePlayer" : NomePlayer,
		"VolumeUI" : VolumeUI,
		"VolumeMusica" : VolumeMusica
	}
	return save_dict

#==========================================================================
###############################################################################

func save_game():
	var File = FileAccess
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		# Call the node's save function.
		var node_data = node.call("save")
		# JSON provides a static method to serialized JSON string
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)
	save_game.close()
