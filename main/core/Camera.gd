extends Camera3D


func _process(delta: float) -> void:
	self.position += lerp(get_node("../Player").global_position, self.global_position, 1.0)
