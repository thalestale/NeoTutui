extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_tween().tween_property($ParallaxBackground/ColorRect2, "texture:noise:fractal_lacunarity", 2.00, 15.00)


