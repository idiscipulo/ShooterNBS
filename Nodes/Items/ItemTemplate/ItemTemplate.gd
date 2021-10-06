extends RigidBody

func _ready():
	pass
	
func drop():
	linear_velocity = Vector3(0, 0, 0)
	print(transform)
	apply_impulse(transform.basis.z, -transform.basis.z * 5)

func _on_ItemSpawner_detach():
	print("detach")
	
	mode = MODE_RIGID
