extends "res://Nodes/Items/ItemTemplate/ItemTemplate.gd"

export var projectile_path : String
export var crosshair_path : String

onready var max_ammo = 10
onready var cur_ammo = 10

onready var animation_player = $AnimationPlayer
var projectile : Resource

func _ready():
	projectile = load(projectile_path)

func drop():
	character.set_crosshair(null)
	.drop()
	
func attach_to_character(x):
	.attach_to_character(x)
	character.set_crosshair(crosshair_path)
	
func main_action():
	if animation_player.is_playing() == false:
		if cur_ammo > 0:
			var aimcast_transform = character.get_node("RotationHelper/Camera").global_transform
			
			var projectile_instance = projectile.instance()
			get_tree().get_root().add_child(projectile_instance)
			projectile_instance.global_transform = aimcast_transform
			projectile_instance.ignore = character

			cur_ammo -= 1
			animation_player.play("Shoot")
			
		else:
			cur_ammo = max_ammo
			animation_player.play("Reload")
