extends RigidBody

signal detach

onready var anchor = $Anchor
export var item_path : String
onready var anchored = false

var item_parent : Resource
var item : Node

func _ready():
	item_parent = load(item_path)
	
	item = item_parent.instance()
	item.mode = MODE_KINEMATIC
	connect("detach", item, "_on_ItemSpawner_detach")
	anchor.add_child(item)
	anchored = true

func _process(delta):
	if anchor.get_child(0) == null and anchored == true:
		emit_signal("detach")
		disconnect("detach", item, "_on_ItemSpawner_detach")
		
		item = item_parent.instance()
		item.mode = MODE_KINEMATIC
		connect("detach", item, "_on_ItemSpawner_detach")
		anchor.add_child(item)
		anchored = true
	else:
		anchor.rotation_degrees = Vector3(0, lerp(anchor.rotation_degrees.y,anchor.rotation_degrees.y + 5, 5 * delta), 0)
