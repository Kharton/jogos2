extends StaticBody2D

onready var anim: AnimationPlayer = get_node("AnimationPlayer")

var opened: bool = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func open():
	if opened:
		return
	anim.play("open")
	opened = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
