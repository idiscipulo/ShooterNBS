extends Area

export var speed = 7
export var max_distance = 40

onready var animation = $AnimationPlayer
onready var collision_shape = $CollisionShape
onready var distance = 0
onready var moving = true

var last_pos : Vector3
var ignore : Node

func _ready():
	animation.play("Throw")
	
func _physics_process(delta):
	if moving:
		last_pos = global_transform.origin
		
		translate_object_local(Vector3(0, 0, -speed * delta))
		
		var cur_pos = global_transform.origin
		var length = (cur_pos - last_pos).length()
		
		collision_shape.look_at(cur_pos, Vector3.UP)
		collision_shape.shape.extents.z = length
		collision_shape.translation.z = length
		
		"""
		distance += speed * delta
		if distance > max_distance:
			queue_free()
		"""

func _on_TripleKnife_body_entered(body):
	if body != ignore:
		print(body.name)
		moving = false
