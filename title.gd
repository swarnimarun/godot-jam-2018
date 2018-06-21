extends Node

signal play_hit

func _ready():
	connect("play_hit", get_parent(), "_on_title_play_hit", [])
	$"bg".playing = true
	setup_colors()

func setup_colors():
	var l = Data.get_color_light()
	var m = Data.get_color_mid()
	var d = Data.get_color_dark()
	
	$"UI/bg".color = l
	$"UI/title".self_modulate = d
	$"UI/GUI/aim".self_modulate = m

func _on_cross_gui_input(ev):
	if ev is InputEventMouseButton:
		$"bg".playing = false
		get_tree().quit()

func _input(event):
	if event is InputEventMouse:
		Data.mousepos = event.position

func _on_cross_mouse_entered():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.8)

func _on_cross_mouse_exited():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.4)

func _on_play_pressed():
	emit_signal("play_hit")
