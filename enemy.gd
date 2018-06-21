extends "res://Entity.gd"

export var health_max = 10
var health = health_max

var my_temp = -10
var stop_follow = false
onready var particles = preload("res://particle.tscn")

func _ready():
	modulate = Data.get_color_dark(my_temp)
	target = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	if target :
		if not stop_follow:
			tpos = target.position + Vector2((randi() % 100 + 10.0), (randi() % 100 + 10.0))
			if position.distance_squared_to(tpos) > 100000000:
				stop_follow = true
		elif position.distance_squared_to(target.position) < 100000000:
			stop_follow = false
	
	if health <= 0:
		die()

func die():
	Data.enemy_count -= 1
	add_points()
	var part = particles.instance()
	part.position = position
	part.emit = true
	part.tcol = Data.get_color_mid(my_temp)
	get_parent().add_child(part)
	get_parent().remove_child(self)
	call_deferred("queue_free")

func add_points():
	randomize()
	if health != 0:
		var p = randi() % health/2 + health_max
		Data.score += p
	else:
		Data.score += health_max

func take_damage(val = false):
	if val == false:
		health -= int(abs(Data.current_temp - my_temp) * 10) / 100 * health_max
	else:
		die()