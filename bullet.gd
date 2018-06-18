extends Sprite

var damage = 10

var timer = 1.0


func _process(delta):
	timer -= delta
	if timer <= 0:
		destroy()
	position += Vector2(sin(rotation), -cos(rotation)) * delta * 1000

func destroy():
	call_deferred("queue_free")


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_parent().take_damage()
	destroy()
