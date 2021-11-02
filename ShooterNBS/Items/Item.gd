class_name Item

extends RigidBody
const ITEM_STATE = preload("res://Enums/ITEM_STATE.gd")

export var path_collision_shape: String

var item_state = ITEM_STATE.DEFAULT
var collision_shape : CollisionShape = null
var parent_entity : Entity = null
var parent_anchor : Node = null

func _ready():
	collision_shape = get_node(path_collision_shape)
	
	print(item_state)

func drop():
	linear_velocity = Vector3(0, 0, 0)
	apply_impulse(transform.basis.z, -transform.basis.z * 5)
	parent_entity = null
	collision_shape.disabled = false
	
func attach_to_anchor(target_anchor: Node):
	parent_anchor = target_anchor
	
func detach_from_anchor():
	pass
	
func attach_to_entity(target_entity: Entity):
	parent_entity = target_entity
	collision_shape.disabled = true
	
func detach_from_entity():
	pass

func _on_ItemSpawner_detach():
	mode = MODE_RIGID
