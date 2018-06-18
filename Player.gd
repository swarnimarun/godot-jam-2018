extends Sprite

export var move_speed = 300.0
export var rot_speed = 5.0
export var health_max = 100

var health = health_max

var bullet = preload("res://bullet.tscn")
onready var spawn_at = get_node("spawn")
onready var spawner = get_node("/root/main/bullets")
onready var sht = get_parent().get_node("shoot")

var timer = 0

var nd = Node2D.new()

func _ready():
	Data.player_original_position = position
	get_parent().call_deferred("add_child", nd)
	nd.set_owner(get_tree().get_edited_scene_root())

func _process(delta):
	if health < health_max/4.0:
		Data.tension += delta * 2.0 
	elif health < health_max/2.0:
		Data.tension += delta
	if Input.is_action_pressed("ui_left_mouse"):
		timer -= delta
		if timer <= 0:
			shoot()
			if Data.normal:
				Data.current_temp += delta * 150.0
			else:
				Data.current_temp -= delta * 150.0
			timer = 0.15
	
	if Input.is_action_just_released("ui_left_mouse"):
		timer = 0
	
	if nd.position.distance_squared_to(Data.mouseposGlobal) > 1600:
		nd.look_at(Vector2(Data.mouseposGlobal.x, Data.mouseposGlobal.y))
		nd.rotate(3.141 / 2)
	
	rotate_to(nd.rotation, delta)
	
	nd.position = position
	position += Vector2(sin(rotation), -cos(rotation)) * delta * move_speed
	
	if health <= 0 or Data.current_temp >= 100 or Data.current_temp <= -50:
		show_quit_GUI()

func show_quit_GUI():
	get_tree().paused = true
	get_parent().show_end()
	

func rotate_to(rot, delta):
	rotation += (nd.rotation - rotation) * delta * rot_speed

func shoot():
	sht.play()
	var b = bullet.instance()
	b.global_position = spawn_at.global_position
	b.rotation = rotation
	b.self_modulate = Data.color_mid
	spawner.add_child(b)


func _on_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_parent().take_damage(true)
		var dmg = body.get_parent().health
		health -= dmg
	elif body.is_in_group("reverse"):
		body.get_parent().destroy()
