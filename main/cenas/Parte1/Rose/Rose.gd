extends Control



func _ready():
	get_tree().create_tween().tween_property($ParallaxBackground/ColorRect2, "texture:noise:fractal_lacunarity", 3.00, 20.00)


