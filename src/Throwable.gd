extends HitBox
class_name Throwable

var exited: bool = false
var speed: int = 0


func launch(init: Vector2, dir: Vector2, spd: int):
	position = init
	direction = dir
	speed = spd
	
	rotation += dir.angle() + 2*PI


func _physics_process(delta):
	position += direction * speed * delta

func _ready():
	pass


func _collide(body: KinematicBody2D):
	if exited:
		if body != null  && body.has_method("take_damage"):
			body.take_damage(damage,direction,push)
		queue_free()


func _on_Throwable_body_exited(_body):
	if !exited:
		exited = true
		set_collision_mask_bit(0,true)
		set_collision_mask_bit(1,false)
		set_collision_mask_bit(2,true)
