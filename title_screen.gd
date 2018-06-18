extends Node2D

onready var bg = $"UI/Background"
onready var title = $"UI/title"

func _ready():
	$bg.playing = true
	setup_colors()

func setup_colors():
	var l = Data.get_color_light()
	var m = Data.get_color_mid()
	var d = Data.get_color_dark()
	
	bg.color = l
	title.self_modulate = d

func _on_cross_gui_input(ev):
	if ev is InputEventMouseButton:
		$bg.playing = false
		get_tree().quit()

func _input(event):
	if event is InputEventMouse:
		Data.mousepos = event.position

func _on_cross_mouse_entered():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.8)

func _on_cross_mouse_exited():
	get_node("UI/GUI/cross").self_modulate = Color(1.0,1.0,1.0,0.4)

func _on_play_button_up():
	get_tree().change_scene("res://main.tscn")
