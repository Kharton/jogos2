extends Navigation2D

const SPAWNS: Array = [preload("res://scn/RoomBoot.tscn")]
const TRANSITIONS: Array = [preload("res://scn/Room0.tscn"),preload("res://scn/Room1.tscn"),preload("res://scn/Room2.tscn")]
const FINISHING: Array = [preload("res://scn/RoomFinish.tscn")]

const TILE_SIZE: int = 16
const ATLAS_TILE: int = 41
const FLOOR_TILE: int = 41
const RIGHT_WALL_TILE: int = 42
const LEFT_WALL_TILE: int = 42

const LEFT_WALL_CORD__TILE: Vector2 = Vector2(3,5)
const RIGHT_WALL_CORD__TILE: Vector2 = Vector2(4,5)
const FLOOR_CORD_TILE: Vector2 = Vector2(3,1)

export(int) var levels: int = 5

onready var player: KinematicBody2D = get_parent().get_node("Player")

func _ready():
	spawn_rooms()

func spawn_rooms():
	var previous: Node2D
	
	for i in levels:
		var room: Node2D
		if i == 0:
			room = SPAWNS[randi()%SPAWNS.size()].instance()
			player.position = room.get_node("PlayerSpawn").position
		else:
			if i == levels -1:
				room = FINISHING[randi()%FINISHING.size()].instance()
			else:
				room = TRANSITIONS[randi()%TRANSITIONS.size()].instance()
				
			var previous_map: TileMap = previous.get_node("TileMap")
			var previous_door: StaticBody2D = previous.get_node("Doors/Door")
			var exit: Vector2 = previous_map.world_to_map(previous_door.position)
			var mapLength: int = randi() % 5+2 
			for y in mapLength+4:
				previous_map.set_cellv(exit+Vector2(-1,-y), ATLAS_TILE,false,false,false,FLOOR_CORD_TILE)
				previous_map.set_cellv(exit+Vector2(0,-y), ATLAS_TILE,false,false,false,FLOOR_CORD_TILE)
				if	y > 1:
					previous_map.set_cellv(exit+Vector2(-2,-y), ATLAS_TILE,false,false,false,RIGHT_WALL_CORD__TILE)
					previous_map.set_cellv(exit+Vector2(1,-y), ATLAS_TILE,false,false,false,LEFT_WALL_CORD__TILE)
		
			var roomTile: TileMap = room.get_node("TileMap")
			room.position = previous_door.global_position
			room.position += Vector2.UP * roomTile.get_used_rect().size.y * TILE_SIZE
			room.position += Vector2.UP * (1+mapLength)*TILE_SIZE
			room.position += Vector2.LEFT * roomTile.world_to_map(room.get_node("Entrance/Position2D").position).x * TILE_SIZE
			
		add_child(room)
		previous = room
