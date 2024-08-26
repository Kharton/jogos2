extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _init() -> void:
	randomize()
	var sreenS: Vector2 = OS.get_screen_size()
	var windowS: Vector2 = OS.get_real_window_size()
	
	OS.window_position = sreenS *0.5 - windowS *0.5
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.change_music("music_title", .1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
