extends RigidBody

func _ready():
	pass
	
func drop():
	apply_impulse(transform.basis.z, -transform.basis.z * 3)
	apply_impulse(transform.basis.y, transform.basis.y * 3)
