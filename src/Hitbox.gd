extends Area2D
class_name HitBox

export(int) var damage: int = 1
var direction: Vector2 = Vector2.ZERO
export(int) var push: int = 300


#onready var parent: Char = get_parent()
onready var coll: CollisionShape2D = get_child(0)

func _init():
	var __ = connect("body_entered", self, "_on_body_entered")
	
func ready():
	assert(coll != null)
	
func _on_body_entered(body: PhysicsBody2D):
	body.take_damage(damage, direction, push)
