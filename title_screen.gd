extends Node2D

var on_title = true

func _process(delta):
	Data.mouseposGlobal = get_global_mouse_position()
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().call_deferred("quit")
	if Input.is_action_just_pressed("ui_accept") and on_title:
		_on_title_play_hit()
	if Input.is_action_just_pressed("ui_accept") and not on_title and get_tree().paused:
		show_title()

func _on_title_play_hit():
	var t = $"title"
	remove_child(t)
	t.queue_free()
	var ld = preload("res://main.tscn").instance()
	add_child(ld)
	on_title = false

func show_title():
	var m = $"main"
	remove_child(m)
	m.queue_free()
	var ld = preload("res://title.tscn").instance()
	add_child(ld)
	on_title = true