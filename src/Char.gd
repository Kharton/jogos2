extends KinematicBody2D
class_name Char, "res://assets/heroes/knight/knight_idle_anim_f0.png"

#atrito de movimento
const friction: float = 0.15

export(int) var acel: int = 40
export(int) var hp: int = 40
export(int) var maxSpeed: int = 100

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
#onready var fsm: FiniteStateMachine = get_node("FiniteStateMachine")

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready():
	pass # Replace with function body.


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, friction)
	pass

# Called when the node enters the scene tree for the first time.
func move() -> void:
	direction = direction.normalized()
	velocity += direction * acel

func flipSprite(vector:Vector2):
	if vector.x > 0 && animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif vector.x <0 && !animated_sprite.flip_h:
		animated_sprite.flip_h = true
	pass
