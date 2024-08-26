extends CanvasLayer


var tile_size:int = 32
var file:File = File.new()
var file_path:String
var level_index:int = 0
var level_max:int = 11
var scene_name:String = "boot"
var esc_scene:PackedScene = preload("res://scn/esc.tscn")
var scene_fade:Node
var savePath:String = "user://savedata.bin"
var passPhrase:String = "OkdfPooie0029?/dll"
var current_music:String = ""

func _process(_delta) -> void:
	# MENU ESC
	var esc:bool = Input.is_action_just_pressed("ui_cancel")

	if esc && !get_tree().paused:
		get_tree().paused = true
		var e = esc_scene.instance()
		get_node("/root").add_child(e)

	elif esc && get_tree().paused:
		get_tree().paused = false
		if has_node("/root/esc_scene"):
			get_node("/root/esc_scene").queue_free()
				
func change_music(node_name:String, delay:float = 1) -> void:
	if !get_node("sfx/"+node_name).is_playing():
		get_node("sfx/"+node_name).play()

	if current_music != "" && current_music != node_name:
		$tween_music.interpolate_property(get_node("sfx/"+current_music), "volume_db", get_node("sfx/"+current_music).volume_db, -80, 1, Tween.TRANS_LINEAR, 0)
		$tween_music.interpolate_property(get_node("sfx/"+node_name), "volume_db", get_node("sfx/"+node_name).volume_db, 0, delay, Tween.TRANS_LINEAR, 0)

	$tween_music.start()
	current_music = node_name
				
func play_sound(node_name:String) -> void:
	if get_node("sfx/"+node_name).is_playing():
		get_node("sfx/"+node_name).stop()
	get_node("sfx/"+node_name).play()
