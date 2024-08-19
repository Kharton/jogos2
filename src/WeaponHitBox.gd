extends HitBox
class_name WeaponHitBox



func _ready():
	pass # Replace with function body.

func _on_HitBox_area_entered(area):
	area.queue_free()
