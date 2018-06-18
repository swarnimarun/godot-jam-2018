extends Node2D

export var move_speed = 150.0
export var rot_speed = 3.0

var target = null
var tpos = Vector2()
var nd = Node2D.new()

func _ready():
	target = null
	get_parent().call_deferred("add_child", nd)
	nd.set_owner(get_tree().get_edited_scene_root())

func _process(delta):
	if target:
		if nd.position.distance_squared_to(tpos) > 1600:
			nd.look_at(Vector2(tpos.x, tpos.y))
			nd.rotate(3.141 / 2)
	
	rotate_to(nd.rotation, delta)
	
	nd.position = position
	position += Vector2(sin(rotation), -cos(rotation)) * delta * move_speed

func rotate_to(rot, delta):
	rotation += (nd.rotation - rotation) * delta * rot_speed
