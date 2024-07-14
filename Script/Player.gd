extends KinematicBody

var can_climb = false


export var speed = 40
export var accel = 10
export var gravity = 50
export var jump = 15

var look_rotation: Vector3 = Vector3.ZERO
onready var head: Spatial = $"%Head"

var move_dir = Vector3.ZERO
var velocity = Vector3.ZERO


var max_angle:float = 70.0
var min_angle:float = -70.0

export var sensitivity: float = 0.1

var captured: bool = true



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	captured = true
	GlobalSignal.connect("power_up" , self, "_power_up")
	GlobalSignal.connect("jump_power" , self, "_jump_power")
	GlobalSignal.connect("power_time" , self, "_power_time")
	GlobalSignal.connect("climbing" , self, "_climbing")
	GlobalSignal.connect("reset_jump" , self, "C")




func _physics_process(delta):
	head.rotation_degrees.x = look_rotation.x
	rotation_degrees.y = look_rotation.y
	if can_climb:
		velocity.y = 0
		if Input.is_action_pressed("climb_down"):
			velocity.y = jump
		elif Input.is_action_pressed("climb_up"):
			velocity.y = -jump
	else:
		velocity.y -= gravity * delta
	


	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump


	move_dir = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "back")).normalized().rotated(Vector3.UP, rotation.y)
	
	
	velocity.x = lerp(velocity.x, move_dir.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, move_dir.z * speed, accel * delta)

	velocity = move_and_slide(velocity, Vector3.UP)

func _climbing(state):
	#if state:
		
	velocity.y = 0
	can_climb = state


func _power_up():
	speed = 70

func _jump_power():
	GlobalSignal.emit_signal("power_time")
	jump = 30





func reset_jump():
	jump = 15




func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if captured:
			captured = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		captured = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


	if not captured:
		 return

	if event is InputEventMouseMotion:
		look_rotation.y -= event.relative.x * sensitivity
		look_rotation.x -= event.relative.y * sensitivity
		look_rotation.x = clamp(look_rotation.x, min_angle, max_angle)



























