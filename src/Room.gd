extends Node2D

const SPAWN: PackedScene = preload("res://scn/Spawn.tscn")

const ENEMY: Dictionary = {
	"FLYING": preload("res://scn/Flying.tscn"),
	"GOBLIN": preload("res://scn/Goblin.tscn")
}

var qtd: int

onready var tilemap: TileMap = get_node("TileMap2")
onready var entrance: Node2D = get_node("Entrance")
onready var doorSpace: Node2D = get_node("Doors")
onready var enemies: Node2D = get_node("EnemyPositions")
onready var detector: Node2D = get_node("Trigger")

# Called when the node enters the scene tree for the first time.
func _ready():
	qtd= enemies.get_child_count()
	
func _open_doors():
	if doorSpace.get_child_count() <= 0:
		pass
	
	for door in doorSpace.get_children():
		door.open()

func _close_entrance():
	for entry in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry.position),42)
		tilemap.set_cellv(tilemap.world_to_map(entry.position)+Vector2.UP,43)
		
func _spawn():
	for spawn in enemies.get_children():
		
		var enemy: KinematicBody2D = ENEMY.values()[randi()%ENEMY.size()].instance()
		var __ = enemy.connect("tree_exited",self,"_on_enemy_killed")
		enemy.global_position = spawn.position
		call_deferred("add_child", enemy)
		
		var spawn_expl: AnimatedSprite = SPAWN.instance()
		spawn_expl.global_position = spawn.position
		call_deferred("add_child", spawn_expl)
		
func _on_enemy_killed():
	qtd -= 1
	if qtd <=0:
		_open_doors()



func _on_Trigger_body_entered(_body: KinematicBody2D):
	if qtd > 0:
		detector.queue_free()
		_close_entrance()
		_spawn()
	else:
		_open_doors()
