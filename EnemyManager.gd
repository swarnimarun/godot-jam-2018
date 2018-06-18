extends Node2D

var enemies = []

onready var player = $"/root/main/player"

onready var dr = $"/root/main/UI/dr"
onready var dt = $"/root/main/UI/dt"
onready var db = $"/root/main/UI/db"
onready var dl = $"/root/main/UI/dl"

onready var rev = preload("res://reverse.tscn")

var show_something_special = false setget set_sh
var norm = false



var timer = 4.0

var i = 0

func set_sh(val):
	show_something_special = val
	norm = Data.normal

func _ready():
	enemies.append(preload("res://enemy_big.tscn"))
	enemies.append(preload("res://enemy_small.tscn"))
	randomize()
	i = randi() % 4
	

func dis():
	dr.visible = false
	dl.visible = false
	db.visible = false
	dt.visible = false
	
func show_enemy_hint():
	if i == 0:
		dis()
		dr.visible = true
	elif i == 1:
		dis()
		dl.visible = true
	elif i == 2:
		dis()
		dt.visible = true
	elif i == 3:
		dis()
		db.visible = true

func reset():
	clear_enemies()
	randomize()
	i = randi() % 4

func clear_enemies():
	for n in get_children():
		remove_child(n)
		n.call_deferred("free")

func _process(delta):
	if Data.enemy_count > 0:
		return
	show_enemy_hint()
	timer -= delta
	
	if timer <= 0:
		if show_something_special:
			special()
			show_something_special = false
		timer = 4.0
		var temp = randi() % 150 - 49
		for e in range(0, (randi() % 10) + 2):
			randomize()
			generate_enemy(temp)
			yield(get_tree().create_timer(0.2),"timeout")
		randomize()
		i = randi() % 4
		dis()

func special():
	if i == 0:
		var random = randi() % int(OS.get_screen_size().y) - OS.get_screen_size().y/2.0
		var pos = player.global_position + Vector2(OS.get_screen_size().x,random)
		var en = rev.instance()
		en.norm = norm
		en.global_position = pos
		add_child(en)
	elif i == 1:
		var random = randi() % int(OS.get_screen_size().y) - OS.get_screen_size().y/2.0
		var pos = player.global_position + Vector2(-OS.get_screen_size().x,random)
		var en = rev.instance()
		en.norm = norm
		en.global_position = pos
		add_child(en)
	elif i == 2:
		var random = fmod(randf(), OS.get_screen_size().x) - OS.get_screen_size().x/2.0
		var pos = player.global_position + Vector2(random,-OS.get_screen_size().y)
		var en = rev.instance()
		en.norm = norm
		en.global_position = pos
		add_child(en)
	elif i == 3:
		var random = fmod(randf(), OS.get_screen_size().x) - OS.get_screen_size().x/2.0
		var pos = player.global_position + Vector2(random, OS.get_screen_size().y)
		var en = rev.instance()
		en.norm = norm
		en.global_position = pos
		add_child(en)

func generate_enemy(temp):
	Data.enemy_count += 1
	if i == 0:
		var random = randi() % int(OS.get_screen_size().y) - OS.get_screen_size().y/2.0
		var pos = player.global_position + Vector2(OS.get_screen_size().x,random)
		var en = enemies[randi() % 2].instance()
		en.global_position = pos
		en.my_temp = temp
		add_child(en)
	elif i == 1:
		var random = randi() % int(OS.get_screen_size().y) - OS.get_screen_size().y/2.0
		var pos = player.global_position + Vector2(-OS.get_screen_size().x,random)
		var en = enemies[randi() % 2].instance()
		en.global_position = pos
		en.my_temp = temp
		add_child(en)
	elif i == 2:
		var random = fmod(randf(), OS.get_screen_size().x) - OS.get_screen_size().x/2.0
		var pos = player.global_position + Vector2(random,-OS.get_screen_size().y)
		var en = enemies[randi() % 2].instance()
		en.global_position = pos
		en.my_temp = temp
		add_child(en)
	elif i == 3:
		var random = fmod(randf(), OS.get_screen_size().x) - OS.get_screen_size().x/2.0
		var pos = player.global_position + Vector2(random, OS.get_screen_size().y)
		var en = enemies[randi() % 2].instance()
		en.global_position = pos
		en.my_temp = temp
		add_child(en)
