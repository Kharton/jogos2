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

#func _ready() -> void:
	#get_node("sfx/music_title").play()
	
func _process(_delta) -> void:
	# MENU ESC
	#if not GLOBAL.scene_name in ["intro"]: # , "title"
		var esc:bool = Input.is_action_just_pressed("ui_cancel")

		if esc && !get_tree().paused:
			get_tree().paused = true
			var e = esc_scene.instance()
			get_node("/root").add_child(e)

		elif esc && get_tree().paused:
			get_tree().paused = false
			if has_node("/root/esc_scene"):
				get_node("/root/esc_scene").queue_free()

func next_scene(scene:String = "", fade_out:float = 1, fade_in:float = .5) -> void:
	scene_name = scene

	scene_fade = scene_fade_out(fade_out)
	yield(scene_fade, "tween_completed")

	if scene == "" || scene == "level":
		level_index += 1

		file_path = "res://scenes/level"+str(level_index)+".tscn"
		if file.file_exists(file_path):
			save_game()
			var __ = get_tree().change_scene(file_path)

		else:
			var __ = get_tree().change_scene("res://scenes/title.tscn")

	else:
		file_path = "res://scenes/"+scene+".tscn"
		if file.file_exists(file_path):
			var __ = get_tree().change_scene(file_path)

	scene_fade = scene_fade_in(fade_in)
	yield(scene_fade, "tween_completed")
	$color.hide()
	get_tree().paused = false

func scene_fade_out(time:float) -> Node:
	get_tree().paused = true
	return scene_fade(0, 1, time)

func scene_fade_in(time:float) -> Node:
	return scene_fade(1, 0, time)

func scene_fade(start:int, end:int, time:float) -> Node:
	$color.modulate = Color(0,0,0,start)
	$color.show()

	$tween.stop_all()
	$tween.interpolate_property($color, "modulate", Color(0,0,0,start), Color(0,0,0,end), time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$tween.start()

	return $tween

func save_game() -> void:
	var __ = file.open_encrypted_with_pass(savePath, File.WRITE, passPhrase)

	var datas:Dictionary = {}
	datas.level = level_index

	file.store_string(JSON.print(datas))
	file.close()

func load_game() -> void:
	if !file.file_exists(savePath):
		level_index = 1

	else:
		var __ = file.open_encrypted_with_pass(savePath, File.READ, passPhrase)
		var datas = parse_json(file.get_as_text())
		file.close()

		level_index = datas.level

# https://docs.godotengine.org/en/3.0/tutorials/misc/handling_quit_requests.html
func _notification(what) -> void:
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			get_tree().quit() # default behavior

func change_music(node_name:String, delay:float = 1) -> void:
	if !get_node("sfx").is_playing():
		get_node("sfx/"+node_name).play()

	if current_music != "" && current_music != node_name:
		$tween_music.interpolate_property(get_node("sfx/"+current_music), "volume_db", get_node("sfx/"+current_music).volume_db, -80, 1, Tween.TRANS_LINEAR, 0)
		$tween_music.interpolate_property(get_node("sfx/"+node_name), "volume_db", get_node("sfx/"+node_name).volume_db, 0, delay, Tween.TRANS_LINEAR, 0)

	$tween_music.start()
	current_music = node_name


