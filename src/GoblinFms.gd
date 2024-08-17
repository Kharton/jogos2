extends RangedFiniteStateMachine
	
func _ready():
	set_state(states.move)
	treshold = 5
	
func _state_logic(_delta: float) -> void:
	if state == states.move:
		parent.chase()
		parent.move()
	pass
