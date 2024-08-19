extends Node2D
class_name Weapon, "res://assets/heroes/knight/weapon_sword_1.png"

onready var anim: AnimationPlayer = get_node("WeaponAnimationPlayer")
onready var particules: Particles2D = get_node("Node2D/Sprite/ChargeParticles")
onready var hitbox: HitBox = get_node("Node2D/Sprite/HitBox")

func get_input():
	if Input.is_action_pressed("ui_attack"):
		if !anim.current_animation == "charge" && !anim.is_playing():
			anim.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if particules.emitting:
			anim.play("especial_attack")
		elif anim.is_playing() && anim.current_animation == "charge":
			anim.play("attack")
			
func move(dir:Vector2):
	if !anim.is_playing() || anim.current_animation == "charge":
		rotation = dir.angle()
		hitbox.direction = dir
		
		
		if scale.y == 1 && dir.x < 0:
			scale.y = -1
		elif scale.y == -1 && dir.x > 0:
			scale.y = 1

func cancel_attack():
	anim.play("cancel_attack")
	
func is_busy()->bool:
	if anim.is_playing() || particules.emitting:
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
