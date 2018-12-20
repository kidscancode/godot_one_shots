extends Node2D

var tilesize = Vector2(64, 64)
var w = 4
var h = 4

onready var texture = $Sprite.texture

func _ready():
	var tex_width = texture.get_width() / tilesize.x
	var tex_height = texture.get_width() / tilesize.y
	var ts = TileSet.new()
	for x in range(tex_width):
		for y in range(tex_height):
			var region = Rect2(x*tilesize.x, y*tilesize.y, tilesize.x, tilesize.y)
			var id = x + y * h
			ts.create_tile(id)
			ts.tile_set_texture(id, texture)
			ts.tile_set_region(id, region)
			var s = RectangleShape2D.new()
			s.extents = tilesize/2
			ts.tile_set_shape(id, 0, s)
			var xform = ts.tile_get_shape_transform(id, 0)
			xform.origin += tilesize/2
			ts.tile_set_shape_transform(id, 0, xform)
	ResourceSaver.save("res://color_tiles_red.tres", ts)