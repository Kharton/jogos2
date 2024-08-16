extends DamagableChar

onready var weapon: Node2D = get_node("Weapon")
onready var weaponAnimation: AnimationPlayer = get_node("Weapon/WeaponAnimationPlayer")
onready var weaponHitbox: Area2D = get_node("Weapon/Node2D/Sprite/HitBox")


func _ready():
	pass # Replace with function body.


func _process(_delta:float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	flipSprite(mouse_direction)
	
	weapon.rotation = mouse_direction.angle()
	
	weaponHitbox.direction = mouse_direction
	
	
	if weapon.scale.y == 1 && mouse_direction.x < 0:
		weapon.scale.y = -1
	elif weapon.scale.y == -1 && mouse_direction.x > 0:
		weapon.scale.y = 1
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func input() -> void:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	
	if Input.is_action_pressed("ui_attack") && !weaponAnimation.is_playing():
		weaponAnimation.play("attack")

	pass
