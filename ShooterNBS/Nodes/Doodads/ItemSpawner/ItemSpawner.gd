extends RigidBody

signal detach

export var wait_time = 3

onready var anchor = $Anchor
onready var respawn_timer = $RespawnTimer
export var item_path : String
onready var anchored = false

var item_parent : Resource
var item : Node

func _ready():
	item_parent = load(item_path)
	
	item = item_parent.instance()
	item.mode = MODE_KINEMATIC
	
	respawn_timer.wait_time = wait_time
	
	connect("detach", item, "_on_ItemSpawner_detach")
	anchor.add_child(item)
	anchor.rotation_degrees = Vector3(0, 0, 0)
	anchored = true

func _process(delta):
	if anchor.get_child(0) == null:
		if	anchored == true:
			emit_signal("detach")
			disconnect("detach", item, "_on_ItemSpawner_detach")
			anchored = false
			respawn_timer.start()
	else:
		anchor.rotation_degrees = Vector3(0, lerp(anchor.rotation_degrees.y,anchor.rotation_degrees.y + 5, 5 * delta), 0)


func _on_RespawnTimer_timeout():
	item = item_parent.instance()
	item.mode = MODE_KINEMATIC
	connect("detach", item, "_on_ItemSpawner_detach")
	anchor.add_child(item)
	anchor.rotation_degrees = Vector3(0, 0, 0)
	anchored = true
