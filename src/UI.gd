extends CanvasLayer

const MIN_HP: int = 24

var max_hp: int = 4

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var hp_bar: TextureProgress = get_node("HealthBar")

onready var hp_bar_tween: Tween = get_node("HealthBar/Tween")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	max_hp = player.hp # Replace with function body.
	_update_hp(100)
	
func _update_hp(new:int):
	var __ = hp_bar_tween.interpolate_property(hp_bar,"value",hp_bar.value,new,0.5,Tween.TRANS_QUINT,Tween.EASE_OUT)
	__ = hp_bar_tween.start()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hp_changed(new_hp):
	var nhp: int =  int((100 - MIN_HP)*float(new_hp)/max_hp)+ MIN_HP
	_update_hp(nhp)
