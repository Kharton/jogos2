extends Weapon
class_name Staff, "res://assets/heroes/mage/staffs.png"

const FIRE: PackedScene = preload("res://scn/Fireball.tscn")

export(int) var projSpeed: int = 80

func _ready():
	pass # Replace with function body.


func _launch():
	var proj: Area2D = FIRE.instance()
	var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	proj.launch(global_position,direction, projSpeed)
	get_tree().current_scene.add_child(proj)
