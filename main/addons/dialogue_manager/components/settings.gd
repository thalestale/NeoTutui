@tool
extends Node


const DialogueConstants = preload("res://addons/dialogue_manager/constants.gd")


### Editor config


static func prepare() -> void:
	# Migrate previous keys
	for key in [
		"states", 
		"missing_translations_are_errors", 
		"wrap_lines", 
		"new_with_template", 
		"custom_test_scene_path"
	]:
		if ProjectSettings.has_setting("dialogue_manager/%s" % key):
			var value = ProjectSettings.get_setting("dialogue_manager/%s" % key)
			ProjectSettings.set_setting("dialogue_manager/%s" % key, null)
			set_setting(key, value)
	
	# Set up defaults
	ProjectSettings.set_setting("dialogue_manager/general/states", ProjectSettings.get_setting("dialogue_manager/general/states", []))
	ProjectSettings.set_initial_value("dialogue_manager/general/states", [])
	ProjectSettings.set_setting("dialogue_manager/general/missing_translations_are_errors", ProjectSettings.get_setting("dialogue_manager/general/missing_translations_are_errors", false))
	ProjectSettings.set_initial_value("dialogue_manager/general/missing_translations_are_errors", false)
	ProjectSettings.set_setting("dialogue_manager/general/wrap_lines", ProjectSettings.get_setting("dialogue_manager/general/wrap_lines", false))
	ProjectSettings.set_initial_value("dialogue_manager/general/wrap_lines", false)
	ProjectSettings.set_setting("dialogue_manager/general/new_with_template", ProjectSettings.get_setting("dialogue_manager/general/new_with_template", true))
	ProjectSettings.set_initial_value("dialogue_manager/general/new_with_template", true)
	ProjectSettings.set_setting("dialogue_manager/general/custom_test_scene_path", ProjectSettings.get_setting("dialogue_manager/general/custom_test_scene_path", "res://addons/dialogue_manager/test_scene.tscn"))
	ProjectSettings.set_initial_value("dialogue_manager/general/custom_test_scene_path", "res://addons/dialogue_manager/test_scene.tscn")


static func set_setting(key: String, value) -> void:
	ProjectSettings.set_setting("dialogue_manager/general/%s" % key, value)
	ProjectSettings.save()


static func get_setting(key: String, default):
	if ProjectSettings.has_setting("dialogue_manager/general/%s" % key):
		return ProjectSettings.get_setting("dialogue_manager/general/%s" % key)
	else:
		return default


### User config


static func get_user_config() -> Dictionary:
	var user_config: Dictionary = {
		just_refreshed = null,
		recent_files = [],
		carets = {},
		run_title = "",
		run_resource_path = "",
		is_running_test_scene = false
	}
	
	if FileAccess.file_exists(DialogueConstants.USER_CONFIG_PATH):
		var file: FileAccess = FileAccess.open(DialogueConstants.USER_CONFIG_PATH, FileAccess.READ)
		user_config.merge(JSON.parse_string(file.get_as_text()), true)
	
	return user_config


static func save_user_config(user_config: Dictionary) -> void:
	var file: FileAccess = FileAccess.open(DialogueConstants.USER_CONFIG_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(user_config))


static func set_user_value(key: String, value) -> void:
	var user_config: Dictionary = get_user_config()
	user_config[key] = value
	save_user_config(user_config)


static func get_user_value(key: String, default = null):
	return get_user_config().get(key, default)


static func add_recent_file(path: String) -> void:
	var recent_files: Array = get_user_value("recent_files", [])
	if path in recent_files:
		recent_files.erase(path)
	recent_files.insert(0, path)
	set_user_value("recent_files", recent_files)


static func move_recent_file(from_path: String, to_path: String) -> void:
	var recent_files: Array = get_user_value("recent_files", [])
	for i in range(0, recent_files.size()):
		if recent_files[i] == from_path:
			recent_files[i] = to_path
	set_user_value("recent_files", recent_files)


static func remove_recent_file(path: String) -> void:
	var recent_files: Array = get_user_value("recent_files", [])
	if path in recent_files:
		recent_files.erase(path)
	set_user_value("recent_files", recent_files)


static func get_recent_files() -> Array:
	return get_user_value("recent_files", [])


static func clear_recent_files() -> void:
	set_user_value("recent_files", [])
	set_user_value("carets", {})


static func set_caret(path: String, cursor: Vector2) -> void:
	var carets: Dictionary = get_user_value("carets", {})
	carets[path] = { 
		x = cursor.x, 
		y = cursor.y
	}
	set_user_value("carets", carets)


static func get_caret(path: String) -> Vector2:
	var carets = get_user_value("carets", {})
	if carets.has(path):
		var caret = carets.get(path)
		return Vector2(caret.x, caret.y)
	else:
		return Vector2.ZERO
