extends Node2D

var collision_pos = []
	
func _process(delta):
	var cpos = $TileMap.world_to_map($Character.position)
	$CanvasLayer/GridContainer/TilePos.text = str(cpos)
	var mpos = $TileMap.world_to_map(get_global_mouse_position())
	$CanvasLayer/GridContainer/MousePos.text = str(mpos)

func _on_Character_collided(collision):
	# KinematicCollision2D object emitted by character
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map($Character.position)
		tile_pos -= collision.normal  # Colliding tile
		var tile = collision.collider.get_cellv(tile_pos)
		if tile > 0:
			$TileMap.set_cellv(tile_pos, tile-1)
	
func _on_Ball_collided(collider, pos, normal):
	if collider is TileMap:
		var tile_pos = collider.world_to_map(pos - normal)
		var tile = collider.get_cellv(tile_pos)
		if tile > 0:
			collider.set_cellv(tile_pos, tile-1)
		