extends HitBox


onready var anim: AnimationPlayer = get_node("AnimationPlayer")# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("active")

func _collide(body: KinematicBody2D):
	if !body.has_method("take_damage"):
		return
	if !body.flying:
		direction = (body.global_position - global_position).normalized()
		body.take_damage(damage, direction, push)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
