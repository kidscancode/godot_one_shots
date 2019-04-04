extends Node2D

func _ready():
	var map_size = $TileMap.get_used_rect()
	var cell_size = $TileMap.cell_size
	$Soldier/Camera2D.limit_left = map_size.position.x * cell_size.x
	$Soldier/Camera2D.limit_top = map_size.position.y * cell_size.y
	$Soldier/Camera2D.limit_right = map_size.end.x * cell_size.x
	$Soldier/Camera2D.limit_bottom = map_size.end.y * cell_size.y
	