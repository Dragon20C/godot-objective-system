class_name Player extends CharacterBody3D

@export var sensitivity = 0.004

var speed
const WALK_SPEED = 4.0
const SPRINT_SPEED = 5.5
const JUMP_VELOCITY = 4.8
const SENSITIVITY = 0.004
var mouse_dir : Vector2 = Vector2.ZERO

#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = get_node("Head")
@onready var camera = get_node("Head/Camera3D")

# Footstep variables:
var can_play : bool = true
var landed : bool = false
signal step(landed)

func _ready():
	SignalBus.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		mouse_dir = -event.relative
		rotate_y(mouse_dir.x * sensitivity)
		camera.rotate_x(mouse_dir.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		landed = false
	
	if is_on_floor() and landed == false:
		emit_signal("step",true)
		emit_signal("step",true)
		landed = true
	
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	#var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	#var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	#camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	
	var low_pos = BOB_AMP - 0.05
	# Check if we have reached a high point so we restart can_play
	if pos.y > -low_pos:
		can_play = true
	
	# check if the head position has reached a low point then turn off can play to avoid
	# multiple spam of the emit signal
	if pos.y < -low_pos and can_play:
		can_play = false
		emit_signal("step",false)
	
	return pos
