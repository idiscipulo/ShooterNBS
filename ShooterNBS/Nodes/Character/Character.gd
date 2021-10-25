extends KinematicBody

export var speed = 7
export var accel_default = 7
export var accel_air = 1
export var gravity = 9.8
export var jump = 5
export var cam_accel = 40
export var mouse_sense = 0.1
export var default_fov = 100
export var ads_fov = 80
export var ads_speed = 20
export var default_position : Vector3
export var ads_position : Vector3
export var default_crosshair_path : String

var accel = accel_default

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

var snap
var item_to_equip
var item_to_drop

onready var rotation_helper = $RotationHelper
onready var hand = $RotationHelper/Hand
onready var camera = $RotationHelper/Camera
onready var aim_cast = $RotationHelper/Camera/AimCast
onready var reach_cast = $RotationHelper/Camera/ReachCast
onready var crosshair = $RotationHelper/Camera/TextureRect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		rotation_helper.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		rotation_helper.rotation.x = clamp(rotation_helper.rotation.x, deg2rad(-89), deg2rad(89))

func _process(delta):
	if Engine.get_frames_per_second() > Engine.iterations_per_second:
		camera.set_as_toplevel(true)
		camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(rotation_helper.global_transform.origin, cam_accel * delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = rotation_helper.rotation.x
	else:
		camera.set_as_toplevel(false)
		camera.global_transform = rotation_helper.global_transform
		
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_just_pressed("interact"):
		if reach_cast.is_colliding():
			var target = reach_cast.get_collider()
			
			if target.is_in_group("Item"):
				var target_parent = target.get_parent()
				target_parent.remove_child(target)
				
				var held_item = hand.get_child(0)
				if held_item != null:
					hand.remove_child(held_item)
					get_tree().get_root().add_child(held_item)
					
					held_item.global_transform = hand.global_transform
					held_item.drop()
					
				target.attach_to_character(self)
				hand.add_child(target)
				target.rotation = hand.rotation
				target.transform = transform.basis
	
	if Input.is_action_pressed("main_action"):
		var held_item = hand.get_child(0)
		
		if held_item != null:
			held_item.main_action()
			
	"""		
	if Input.is_action_pressed("aim"):
		hand.transform.origin = hand.transform.origin.linear_interpolate(ads_position, ads_speed * delta)
		camera.fov = lerp(camera.fov, ads_fov, ads_speed * delta)
	else:
		hand.transform.origin = hand.transform.origin.linear_interpolate(default_position, ads_speed * delta)
		camera.fov = lerp(camera.fov, default_fov, ads_speed * delta)
	"""
	
func _physics_process(delta):
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	if is_on_floor():
		snap = -get_floor_normal()
		accel = accel_default
		gravity_vec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = accel_air
		gravity_vec += Vector3.DOWN * gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap = Vector3.ZERO
		gravity_vec = Vector3.UP * jump
		
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)

func set_crosshair(crosshair_path):
	var texture
	
	if crosshair_path == null:
		texture = load(default_crosshair_path)
	else:
		texture = load(crosshair_path)
		
	crosshair.texture = texture
