extends GroundEnemy
class_name Goblin, "res://assets/enemies/goblin/goblin_idle_anim_f0.png"

const MAX_DISTANCE: int = 160
const MIN_DISTANCE: int = 70
const KNIFE: PackedScene = preload("res://scn/ThorwableKnife.tscn")


export(int) var projSpeed: int = 70
var canAttack: bool = true
var distance: float

onready var atkTimer: Timer = get_node("AttackTimer")

onready var aim: RayCast2D = get_node("AimRayCast")

func _ready():
	pass # Replace with function body.


func _on_PathTimer_timeout():
	if is_instance_valid(player):
		distance = (player.position - global_position).length()
		if(distance > MAX_DISTANCE):
			_get_chase()
		elif distance < MIN_DISTANCE:
			_get_run()
		else:
			aim.cast_to = player.position - global_position
			if canAttack && fsm.state == fsm.states.idle && !aim.is_colliding():
				canAttack = false
				_throw()
				atkTimer.start()
	else:
		timer.stop()
		path = []
		direction = Vector2.ZERO


func _get_run():
	var dir: Vector2 = (global_position - player.position).normalized()
	path = nav.get_simple_path(global_position, global_position + dir*100)


func _on_AttackTimer_timeout():
	canAttack = true
	
func _throw():
	var proj: Area2D = KNIFE.instance()
	proj.launch(global_position,(player.position - global_position).normalized(), projSpeed)
	get_tree().current_scene.add_child(proj)
