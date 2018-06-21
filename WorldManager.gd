extends Node2D

onready var bg = $"UI/Background"
onready var aim = $"newUI/aim"
onready var player = $player

onready var board_heat = $"UI/board_heat"
onready var board_cold = $"UI/board_cold"

signal home_screen

#var sc = preload("res://title_screen.tscn")

func _enter_tree():
	Data.reload_scene()
	$enemies.reset()
	get_tree().paused = false

func _ready():
	connect("home_screen", get_parent(), "show_title", [])
	$bg.playing = true
	setup_colors()

func setup_colors():
	var l = Data.get_color_light()
	var m = Data.get_color_mid()
	var d = Data.get_color_dark()
	
	bg.color = l
	aim.self_modulate = m
	player.self_modulate = m

func show_end():
	Data.high_score = Data.score
	$"newUI/home".visible = true
	$"newUI/return".visible = true
	$"newUI/game over".visible = true
	$"newUI/high score".visible = true
	$"UI/GUI/score".visible = false
	$"newUI/high score".text = "High Score: " + str(Data.high_score)


func _physics_process(delta):
	$"UI/GUI/score".text = "Score: " + str(Data.score)
	if Data.current_temp >= 70:
		board_heat.visible = true
		Data.tension = delta * 200.0 * (Data.current_temp - 70.0) / 30.0
		if Data.normal:
			$enemies.show_something_special = true
	else:
		board_heat.visible = false

	if Data.current_temp <= -20:
		board_cold.visible = true
		Data.tension = delta * 200.0 * (-20 - Data.current_temp) / 30.0
		if not Data.normal:
			$enemies.show_something_special = true
	else:
		board_cold.visible = false
	
	if Data.normal:
		Data.current_temp -= delta
	else:
		Data.current_temp += delta
	setup_colors()

func _on_cross_gui_input(ev):
	if ev is InputEventMouseButton:
		$bg.playing = false
		get_tree().call_deferred("quit")

func _input(event):
	if event is InputEventMouse:
		Data.mousepos = event.position

func _on_cross_mouse_entered():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.8)

func _on_cross_mouse_exited():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.4)

func _on_gear_mouse_entered():
	get_node("UI/GUI/gear").self_modulate = Color(1.0,1.0,1.0,0.8)

func _on_gear_mouse_exited():
	get_node("UI/GUI/gear").self_modulate = Color(1.0,1.0,1.0,0.4)

func _on_gear_gui_input(ev):
	if ev is InputEventMouseButton:
		get_tree().paused = true
		var nodes = get_tree().get_nodes_in_group("Pause")
		for n in nodes:
			n.visible = true
		get_node("bg").volume_db = -20
		get_node("UI/GUI/gear").visible = false

func _on_right_gui_input(ev):
	if ev is InputEventMouseButton:
		get_tree().paused = false
		var nodes = get_tree().get_nodes_in_group("Pause")
		for n in nodes:
			n.visible = false
		get_node("bg").volume_db = -13
		get_node("UI/GUI/gear").visible = true
		_on_right_mouse_exited()

func _on_right_mouse_entered():
	get_node("UI/GUI/right").self_modulate = Color(1.0,1.0,1.0,0.91)

func _on_right_mouse_exited():
	get_node("UI/GUI/right").self_modulate = Color(1.0,1.0,1.0,0.5)

func _on_return_gui_input(ev):
	if ev is InputEventMouseButton:
		Data.reload_scene()
		$enemies.reset()
		get_tree().paused = false
		var nodes = get_tree().get_nodes_in_group("Pause")
		for n in nodes:
			n.visible = false
		get_node("UI/GUI/gear").visible = true
		_on_return_mouse_exited()

func _on_return_mouse_entered():
	get_node("UI/GUI/return").self_modulate = Color(1.0,1.0,1.0,1.0)


func _on_return_mouse_exited():
	get_node("UI/GUI/return").self_modulate = Color(1.0,1.0,1.0,0.5)

func _on_audioOn_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.is_pressed():
			$shoot.playing = not $shoot.playing
			#$click.playing = not $click.playing
			if not $shoot.playing:
				get_node("UI/GUI/audioOn").texture = load("res://UI/audioOff.png")
			else:
				get_node("UI/GUI/audioOn").texture = load("res://UI/audioOn.png")

func _on_audioOn_mouse_entered():
	get_node("UI/GUI/audioOn").self_modulate = Color(1.0,1.0,1.0,1.0)

func _on_audioOn_mouse_exited():
	get_node("UI/GUI/audioOn").self_modulate = Color(1.0,1.0,1.0,0.5)

func _on_musicOn_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.is_pressed():
			$bg.playing = not $bg.playing
			if not $bg.playing:
				get_node("UI/GUI/musicOn").texture = load("res://UI/musicOff.png")
			else:
				get_node("UI/GUI/musicOn").texture = load("res://UI/musicOn.png")

func _on_musicOn_mouse_entered():
	get_node("UI/GUI/musicOn").self_modulate = Color(1.0,1.0,1.0,1.0)

func _on_musicOn_mouse_exited():
	get_node("UI/GUI/musicOn").self_modulate = Color(1.0,1.0,1.0,0.5)

func _on_returnnew_gui_input(ev):
	if ev is InputEventMouseButton:
		Data.reload_scene()
		get_tree().paused = false
		var nodes = get_tree().get_nodes_in_group("endgui")
		for n in nodes:
			n.visible = false
		$"UI/GUI/score".visible = true
		_on_return_mouse_exited()

func _on_returnnew_mouse_entered():
	get_node("newUI/return").self_modulate = Color(1.0,1.0,1.0,1.0)


func _on_returnnew_mouse_exited():
	get_node("newUI/return").self_modulate = Color(1.0,1.0,1.0,0.5)


func _on_homenew_gui_input(ev):
	if ev is InputEventMouseButton:
		get_tree().paused = false
		emit_signal("home_screen")


func _on_homenew_mouse_entered():
	get_node("newUI/home").self_modulate = Color(1.0,1.0,1.0,1.0)


func _on_homenew_mouse_exited():
	get_node("newUI/home").self_modulate = Color(1.0,1.0,1.0,0.5)
