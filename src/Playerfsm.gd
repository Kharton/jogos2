extends FiniteStateMachine
class_name MovingFiniteStateMachine


var treshold: int = 10

# Called when the node enters the scene tree for the first time.
func _init():
	_add_state("idle")
	_add_state("move")
	_add_state("hurt")
	_add_state("dead")
	
	pass # Replace with function body.
	
func _ready():
	set_state(states.idle)
	
	pass # Replace with function body.

func _state_logic(_delta: float) -> void:
	if state != states.dead:
		parent.input()
		parent.move()
	else:
		treshold = 15
		#parent.queue_free()
	pass

func _get_transition() -> int:
	match state:
		states.idle:
			if(parent.velocity.length()) > treshold:
				return states.move
		states.move:
			if(parent.velocity.length()) < treshold:
				return states.idle
		states.hurt:
			if(!animation_player.is_playing()):
				return states.move
	return -1
	
func _enter_state(_prev: int, new: int) -> void:
	match new:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")
		states.hurt:
			animation_player.play("hurt")
			if parent.has_method("cancel_attack"):
				parent.cancel_attack()
		states.dead:
			animation_player.play("dead")
			if parent.has_method("cancel_attack"):
				parent.cancel_attack()
	pass
