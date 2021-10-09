extends "res://Nodes/Items/ItemTemplate/ItemTemplate.gd"

export var projectile_path : String
var projectile : Resource

func _ready():
	projectile = load(projectile_path)
	
func main_action():
	var aimcast_transform = character.get_node("RotationHelper/Camera").global_transform
	
	var projectile_instance = projectile.instance()
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.global_transform = aimcast_transform
