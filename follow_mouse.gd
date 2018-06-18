extends TextureRect

func _process(delta):
	rect_position = Data.mousepos - Vector2(8,8)
