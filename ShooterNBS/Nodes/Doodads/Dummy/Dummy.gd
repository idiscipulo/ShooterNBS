extends RigidBody

onready var health = 100

func _ready():
	pass
	
func damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
		return true
	else:
		return false
