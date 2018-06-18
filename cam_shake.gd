extends Camera2D

var org_position = Vector2()
var org_scale = Vector2()

func _physics_process(delta):
	if Data.tension >= 0:
		shake()
		Data.tension -= delta * (Data.tension + 1.0)
	elif Data.tension < 0:
		org_position = position
		Data.tension = 0

func shake():
	translation_shake(Data.tension)

func translation_shake(tension):
	randomize()
	var x = tension * tension * tension * ((randi() % 10) - 5) * 0.05
	randomize()
	var y = tension * tension * tension * ((randi() % 10) - 5) * 0.05
	position = org_position + Vector2(x,y)
