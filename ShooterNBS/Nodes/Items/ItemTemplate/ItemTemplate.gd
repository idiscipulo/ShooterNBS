extends RigidBody

var character : Node

onready var collision_shape = $CollisionShape

func _ready():
	character = null
	
func drop():
	linear_velocity = Vector3(0, 0, 0)
	apply_impulse(transform.basis.z, -transform.basis.z * 5)
	character = null
	collision_shape.disabled = false
	
func attach_to_character(x):
	character = x
	collision_shape.disabled = true

func _on_ItemSpawner_detach():
	mode = MODE_RIGID
