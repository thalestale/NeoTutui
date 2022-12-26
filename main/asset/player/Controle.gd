##### CONTROLE DO PLAYER BASEADO 3D PLATFORMER #################################

extends CharacterBody3D
enum Anim {FLOOR, AIR,}
enum AnimPause {PLAYING, PAUSED,}
var linear_velocity = Vector3()
var PoeiraPlaying = 0
var movement_dir = Vector3()
var PodePoeira = get_node("../../Cena").PodePoeira
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var vhorizontal = Vector3()

#### AJUSTAVEIS ################################################################

const SHARP_TURN_THRESHOLD = 120
const MAX_SPEED = 5
const TURN_SPEED = 40
const ACCEL = 14.0
const DEACCEL = 14.0
const CHAR_SCALE = Vector3(1, 1, 1)
const AIR_ACCEL_FACTOR = 0.4
const AIR_IDLE_DEACCEL = false
var movement_vec2 = Vector2()

################################################################################
################################################################################

func _ready() -> void:
	var tipocabelo = get_node("/root/autoload/Dados").tipocabelo
	if tipocabelo == 0:
		$Armature/Skeleton/CabeloComum.visible = true
		$Armature/Skeleton/CabeloB.visible = false
		$Armature/Skeleton/CabeloC.visible = false
	if tipocabelo == 1:
		$Armature/Skeleton/CabeloComum.visible = false
		$Armature/Skeleton/CabeloB.visible = true
		$Armature/Skeleton/CabeloC.visible = false
	if tipocabelo == 2:
		$Armature/Skeleton/CabeloComum.visible = false
		$Armature/Skeleton/CabeloB.visible = false
		$Armature/Skeleton/CabeloC.visible = true

func _physics_process(delta) -> void:

	linear_velocity += gravity * delta

	var anim = Anim.FLOOR

	var vvertical = linear_velocity.y # Vertical velocity.
	vhorizontal = Vector3(linear_velocity.x, 0, linear_velocity.z) # Horizontal velocity.
	var dirhorizontal = vhorizontal.normalized() # Horizontal direction.
	var speedhorizontal = vhorizontal.length() # Horizontal speed
	
	var cam_basis = get_viewport().get_camera().get_global_transform().basis
	movement_vec2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direcao = cam_basis * Vector3(movement_vec2.x, 0, movement_vec2.y)
	direcao.y = 0
	direcao = direcao.normalized()
	
	$AnimationTree["parameters/paranim/current"] = AnimPause.PLAYING
	
	############################################################################
	

	if is_on_floor():
		var sharp_turn = speedhorizontal > 0.1 and rad2deg(acos(direcao.dot(dirhorizontal))) > SHARP_TURN_THRESHOLD

		if direcao.length() > 0.1 and not sharp_turn:
			if speedhorizontal > 0.01:
				dirhorizontal = adjust_facing(dirhorizontal, direcao, delta, 1.0 / speedhorizontal * TURN_SPEED, Vector3.UP)
			else:
				dirhorizontal = direcao

			if speedhorizontal < MAX_SPEED:
				speedhorizontal += ACCEL * delta
		else:
			speedhorizontal -= DEACCEL * delta
			if speedhorizontal < 0:
				speedhorizontal = 0

		vhorizontal = dirhorizontal * speedhorizontal
		
		var mesh_xform = get_node("Armature").get_transform()
		var facing_mesh = -mesh_xform.basis[0].normalized()
		facing_mesh = (facing_mesh - Vector3.UP * facing_mesh.dot(Vector3.UP)).normalized()

		if speedhorizontal > 0:
			facing_mesh = adjust_facing(facing_mesh, direcao, delta, 1.0 / speedhorizontal * TURN_SPEED, Vector3.UP)
		var m3 = Basis(-facing_mesh, Vector3.UP, -facing_mesh.cross(Vector3.UP).normalized()).scaled(CHAR_SCALE)

		get_node("Armature").set_transform(Transform(m3, mesh_xform.origin))
		
	else:
		anim = Anim.AIR

		if direcao.length() > 0.1:
			vhorizontal += direcao * (ACCEL * AIR_ACCEL_FACTOR * delta)
			if vhorizontal.length() > MAX_SPEED:
				vhorizontal = vhorizontal.normalized() * MAX_SPEED
		elif AIR_IDLE_DEACCEL:
			speedhorizontal = speedhorizontal - (DEACCEL * AIR_ACCEL_FACTOR * delta)
			if speedhorizontal < 0:
				speedhorizontal = 0
			vhorizontal = dirhorizontal * speedhorizontal
		
	linear_velocity = vhorizontal + Vector3.UP * vvertical

	if is_on_floor():
		movement_dir = linear_velocity

	linear_velocity = move_and_slide(linear_velocity, -gravity.normalized())

	####### ANIMA ##############################################################
	var walkblend = speedhorizontal / MAX_SPEED
	
	if walkblend > 0.3 and PoeiraPlaying < 2 and PodePoeira:
		poeira()
	
	if is_on_floor():
		$AnimationTree["parameters/walk/blend_amount"] = walkblend

	$AnimationTree["parameters/state/current"] = Anim.FLOOR  #para ativar air colocar var anim aqui
	$AnimationTree["parameters/air_dir/blend_amount"] = clamp(-linear_velocity.y / 4 + 0.5, 0, 1)



################################################################################
################################################################################


func adjust_facing(p_facing, p_target, p_step, p_adjust_rate, current_gn):
	var n = p_target # Normal.
	var t = n.cross(current_gn).normalized()

	var x = n.dot(p_facing)
	var y = t.dot(p_facing)

	var ang = atan2(y,x)

	if abs(ang) < 0.001: # Too small.
		return p_facing

	var s = sign(ang)
	ang = ang * s
	var turn = ang * p_adjust_rate * p_step
	var a
	if ang < turn:
		a = ang
	else:
		a = turn
	ang = (ang - a) * s

	return (n * cos(ang) + t * sin(ang)) * p_facing.length()
	
func paraanim():
	$AnimationTree["parameters/paranim/current"] = AnimPause.PAUSED
	
#===============================================================================
	
func poeira():
	PoeiraPlaying = PoeiraPlaying + 1
	var poeirapos = self.translation
	var poeirapos2 = poeirapos
	var poeiranode = get_node("/root/autoload/dust")
	var poeira1 = poeiranode.duplicate()
	poeira1.playing = true
	poeira1.translation = poeirapos2
	poeira_timer()
	get_node("../../Cena").add_child(poeira1)
	await poeira1.animation_finished
	poeira1.queue_free()
	
func poeira_timer():
	await get_tree().create_timer(0.23).timeout
	PoeiraPlaying = PoeiraPlaying -1
