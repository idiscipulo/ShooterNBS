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
	
func attach_to_anchor(target_anchor: Node):
	parent_anchor = target_anchor
	collision_shape.disabled = true
	mode = MODE_KINEMATIC
	
func detach_from_anchor():
	parent_anchor = null
	collision_shape.disabled = false
	mode = MODE_RIGID
	
func attach_to_entity(target_entity: Entity):
	parent_entity = target_entity
	collision_shape.disabled = true
	
func detach_from_entity():
	parent_entity = null
	collision_shape.disabled = false

func drop():
	detach_from_entity()
	
	get_tree().get_root().add_child(self)
	
	linear_velocity = Vector3(0, 0, 0)
	apply_impulse(transform.basis.z, -transform.basis.z * 5)
