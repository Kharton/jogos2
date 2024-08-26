extends DamagableChar

var weapon: Node2D 

onready var weapons: Node2D = get_node("Weapons")

enum {UP, DOWN}


func _ready():
	weapon = weapons.get_child(0)

func _process(_delta:float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	flipSprite(mouse_direction)
	if weapon.has_method("move"):
		weapon.move(mouse_direction)
	
	pass


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
		
	if !weapon.is_busy():
		if Input.is_action_pressed("ui_switch_up_weapon"):
			_switch_weapon(UP)
		elif Input.is_action_pressed("ui_switch_down_weapon"):
			_switch_weapon(DOWN)
		
	if weapon.has_method("get_input"):
		weapon.get_input()
	
func cancel_attack():
	weapon.cancel_attack()
	
func _switch_weapon(dir:int):
	var i: int = weapon.get_index()
	if dir == UP:
		i -= 1
		if i < 0:
			i = weapons.get_child_count() -1
	else:
		i += 1
		if i >= weapons.get_child_count():
			i = 0
	weapon.hide()
	weapon = weapons.get_child(i)
	weapon.show()
	#ui_switch_down_weapon
	

func take_damage(damage: int, dir:Vector2, push:int):
	if fsm.state == fsm.states.hurt:
		return
		
	self.hp -= damage
	velocity += dir * push
	
	if hp > 0:
		fsm.set_state(fsm.states.hurt)
		GLOBAL.play_sound("sfx_hit_player")
	else:
		fsm.set_state(fsm.states.dead)
		GLOBAL.play_sound("sfx_dead")
	pass
	
func switch_camera():
	var main:Camera2D = get_parent().get_node("Camera2D")
	main.position = position
	main.current = true
	get_node("Camera2D").current = false
