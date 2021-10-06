extends RigidBody

signal detach

onready var anchor = $Anchor
export var item_path : String

var item_parent : Resource
var item : Node

func _ready():
	item_parent = load(item_path)
	
	item = item_parent.instance()
	item.mode = MODE_KINEMATIC
	connect("detach", item, "_on_ItemSpawner_detach")
	anchor.add_child(item)

func _process(delta):
	if anchor.get_child(0) == null:
		emit_signal("detach")
		disconnect("detach", item, "_on_ItemSpawner_detach")
		
		item = item_parent.instance()
		item.mode = MODE_KINEMATIC
		connect("detach", item, "_on_ItemSpawner_detach")
		anchor.add_child(item)
