extends Char
class_name DamagableChar, "res://assets/heroes/knight/knight_idle_anim_f0.png"

onready var fsm: FiniteStateMachine = get_node("FiniteStateMachine")

func _ready():
	pass # Replace with function body.

func take_damage(damage: int, dir:Vector2, push:int):
		
	self.hp -= damage
	velocity += dir * push
	
	if hp > 0:
		fsm.set_state(fsm.states.hurt)
		GLOBAL.play_sound("sfx_hit")
	else:
		fsm.set_state(fsm.states.dead)
	pass
