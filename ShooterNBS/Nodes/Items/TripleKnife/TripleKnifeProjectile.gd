extends Area

export var speed = 7
export var max_distance = 60

onready var animation = $AnimationPlayer
onready var collision_shape = $CollisionShape
onready var audio_stream_player = $AudioStreamPlayer
onready var distance = 0
onready var moving = true

var last_pos : Vector3
var ignore : Node
var hit_sound : Resource
var rotate_rad : float

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
		
		collision_shape.rotate_object_local(Vector3.FORWARD, rotate_rad)
		
		distance += speed * delta
		if distance > max_distance:
			queue_free()

func _on_TripleKnife_body_entered(body):
	if body != ignore:
		if moving:
			print(body.name)
			visible = false
			moving = false
			
			if body.is_in_group("Targetable"):
				var ret = body.damage(33)
				if ret:
					audio_stream_player.play(0.3)
				else:
					audio_stream_player.play(0.5)
			else:
				audio_stream_player.play(0.6)
		
func _on_AudioStreamPlayer_finished():
	queue_free()
