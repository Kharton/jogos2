extends MovingFiniteStateMachine
class_name RangedFiniteStateMachine
	
func _ready():
	set_state(states.move)
	treshold = 5
	
func _state_logic(_delta: float) -> void:
	if state == states.move:
		parent.chase()
		parent.move()

func _get_transition() -> int:
	match state:
		states.idle:
			if parent.distance > parent.MAX_DISTANCE || parent.distance < parent.MIN_DISTANCE:
				return states.move
		states.move:
			if parent.distance < parent.MAX_DISTANCE && parent.distance > parent.MIN_DISTANCE:
				return states.idle
		states.hurt:
			if(!animation_player.is_playing()):
				return states.move
	return -1
