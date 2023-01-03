extends Camera3D

var cam_pos : Vector3
var default_distance : float
var current_dis : float
var is_fov_adjusting : bool = false
var fov_adj_speed : float

@onready var default_fov : float = self.fov

func _ready() -> void:
	default_distance = get_node("../Player").global_position.distance_to(self.position)
	self.fov = default_fov - 5

func _process(delta: float) -> void:
	cam_pos = lerp(get_node("../Player").global_position, self.position, 0.97)
	current_dis = self.position.distance_to(get_node("../Player").position)
	self.position = Vector3(cam_pos.x, self.position.y, lerp(get_node("../Player").position.z + default_distance, self.position.z, 0.97))
	
	current_dis += -default_distance
	if current_dis > 3.30 and not is_fov_adjusting:
		is_fov_adjusting = true
		_fov_adjust(default_fov + 5)

	elif current_dis < 3.10 and not is_fov_adjusting:
		is_fov_adjusting = true
		_fov_adjust(default_fov + 5)

	elif current_dis > 3.10 and current_dis < 3.30 and not is_fov_adjusting:
		is_fov_adjusting = true
		_fov_adjust(default_fov - 5)

	
func _fov_adjust(desired_fov : float) -> void:
	if desired_fov < default_fov:
		get_tree().create_tween().tween_property(self, 
			"fov", 
			desired_fov, 
			4.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).from_current()
		await get_tree().create_timer(2.0).timeout
	else:
		get_tree().create_tween().tween_property(self, 
			"fov", 
			desired_fov, 
			1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).from_current()
		await get_tree().create_timer(1.0).timeout

	is_fov_adjusting = false
