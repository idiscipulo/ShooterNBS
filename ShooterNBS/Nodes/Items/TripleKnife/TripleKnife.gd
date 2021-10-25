extends "res://Nodes/Items/ItemTemplate/ItemTemplate.gd"

export var projectile_path : String
export var crosshair_path : String

onready var rand = RandomNumberGenerator.new()

onready var max_ammo = 3
onready var cur_ammo = 3

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
			var rotate_rad = rand.randf_range(-0.5, 0.5)
			projectile_instance.rotate_object_local(Vector3.FORWARD, rotate_rad)
			projectile_instance.rotate_rad = rotate_rad
			projectile_instance.ignore = character
			
			cur_ammo -= 1
			animation_player.play("Throw")
			
		else:
			cur_ammo = max_ammo
			animation_player.play("Reload")

