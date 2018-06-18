extends Node2D

var emit = false setget set_emit

var tcol = Color() setget set_t

func set_t(val):
	$p1.self_modulate = val

func set_emit(val):
	emit = val
	$p1.emitting = val
	time = 0.5

var time = 0

func _process(delta):
	time -= delta
	if time < 0:
		destroy()

func destroy():
	get_parent().remove_child(self)
	call_deferred("queue_free")