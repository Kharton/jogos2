extends DamagableChar

onready var weapon: Node2D = get_node("Weapon")
onready var weaponAnimation: AnimationPlayer = get_node("Weapon/WeaponAnimationPlayer")
onready var weaponHitbox: Area2D = get_node("Weapon/Node2D/Sprite/HitBox")
onready var particles: Particles2D = get_node("Weapon/Node2D/Sprite/ChargeParticles")


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
	
	if Input.is_action_pressed("ui_attack"):
		if weaponAnimation.current_animation != "charge" && !weaponAnimation.is_playing():
			weaponAnimation.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if particles.emitting:
			weaponAnimation.play("circular_attack")
		elif weaponAnimation.is_playing() && weaponAnimation.current_animation == "charge":
			weaponAnimation.play("attack")
			
	pass
	
func cancel_attack():
	weaponAnimation.play("cancel_attack")
	

func take_damage(damage: int, dir:Vector2, push:int):
	if fsm.state == fsm.states.hurt:
		return
		
	self.hp -= damage
	velocity += dir * push
	
	if hp > 0:
		fsm.set_state(fsm.states.hurt)
	else:
		fsm.set_state(fsm.states.dead)
	pass
	
func switch_camera():
	var main:Camera2D = get_parent().get_node("Camera2D")
	main.position = position
	main.current = true
	get_node("Camera2D").current = false
