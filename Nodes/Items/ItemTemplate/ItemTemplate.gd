extends RigidBody

var dropped = false

func _ready():
	pass
	
func _process(delta):
	if dropped == true:
		apply_impulse(transform.basis.z, -transform.basis.z * 3)
		apply_impulse(transform.basis.y, transform.basis.y * 3)
		dropped = false 
