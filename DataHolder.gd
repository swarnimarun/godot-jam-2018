extends Node

var mousepos = Vector2()
var mouseposGlobal = Vector2()

var title_screen = null

var original_temp = 20
var current_temp = original_temp
var colors_light = {100:Color(1.0,0.314,0.314,1.0), 70:Color(1.0,0.702,0.502,1.0), 40:Color(1.0,0.902,0.502,1.0), 20:Color(0.898,1.0,0.502,1.0), 0:Color(0.655,0.970,0.760,1.0), -20:Color(0.686,0.914,0.866,1.0), -50:Color(0.835,0.898,1.0,1.0)}
var colors_mid = {100:Color(0.784,0.216,0.216,1.0), 70:Color(1.0,0.498,0.165,1.0), 40:Color(1.0,0.8,0.0,1.0), 20:Color(0.671,0.784,0.216,1.0), 0:Color(0.443,0.784,0.216,1.0), -20:Color(0.216,0.784,0.671,1.0), -50:Color(0.216,0.443,0.784,1.0)}
var colors_dark = {100:Color(0.627,0.173,0.173,1.0), 70:Color(0.831,0.333,0.0,1.0), 40:Color(0.866,0.694,0.0,1.0), 20:Color(0.537,0.627,0.173,1.0), 0:Color(0.353,0.627,0.173,1.0), -20:Color(0.173,0.627,0.537,1.0), -50:Color(0.173,0.353,0.627,1.0)}

var color_light = Color()
var color_mid = Color()
var color_dark = Color()

var normal = true
var tension = 0  # 0 to 1

var score = 0
var enemy_count = 0
var high_score = 0

var player_original_position = Vector2()

var reset = false

func _process(delta):
	if Input.is_action_just_pressed("ui_f11"):
		OS.window_fullscreen = not OS.window_fullscreen

func reload_scene():
	enemy_count = 0
	score = 0
	tension = 0
	current_temp = original_temp
	reset = true
	normal = true
	var p = get_tree().get_nodes_in_group("player")
	if p.size() > 0:
		p[0].position = player_original_position
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	reset = false
func mix(col1, col2, factor): # factor = 0 returns col1, factor = 1 returns col2
	if factor <= 0.0:
		return col1
	elif factor >= 1.0:
		return col2
	var dif = (col2 - col1) * factor
	var col = col1 + dif
	return col

func get_color_light(val = -1000):
	var curt = 0
	if val == -1000:
		current_temp = clamp(current_temp,-50,100)
		curt = current_temp
	else:
		val = clamp(val,-50,100)
		curt = val
	var coll 
	if curt >= 70:
		var factor = curt - 70.0
		factor /= 30.0
		coll = mix( colors_light[70],  colors_light[100], factor)
	elif curt >= 40:
		var factor = curt - 40.0
		factor /= 30.0
		coll = mix( colors_light[40],  colors_light[70], factor)
	elif curt >= 20:
		var factor = curt - 20.0
		factor /= 20.0
		coll = mix( colors_light[20],  colors_light[40], factor)
	elif curt >= 0:
		var factor = curt
		factor /= 20.0
		coll = mix( colors_light[0],  colors_light[20], factor)
	elif curt >= -20:
		var factor = curt + 20.0
		factor /= 20.0
		coll = mix( colors_light[-20],  colors_light[0], factor)
	else:
		var factor = curt + 50.0
		factor /= 30.0
		coll = mix( colors_light[-50],  colors_light[-20], factor)
	
	if val == -1000:
		color_light = coll
	return coll

func get_color_mid(val = -1000):
	var curt = 0
	if val == -1000:
		current_temp = clamp(current_temp,-50,100)
		curt = current_temp
	else:
		val = clamp(val,-50,100)
		curt = val
	var colm
	if curt >= 70:
		var factor = curt - 70.0
		factor /= 30.0
		colm = mix( colors_mid[70],  colors_mid[100], factor)
	elif curt >= 40:
		var factor = curt - 40.0
		factor /= 30.0
		colm = mix( colors_mid[40],  colors_mid[70], factor)
	elif curt >= 20:
		var factor = curt - 20.0
		factor /= 20.0
		colm = mix( colors_mid[20],  colors_mid[40], factor)
	elif curt >= 0:
		var factor = curt
		factor /= 20.0
		colm = mix( colors_mid[0],  colors_mid[20], factor)
	elif curt >= -20:
		var factor = curt + 20.0
		factor /= 20.0
		colm = mix( colors_mid[-20],  colors_mid[0], factor)
	else:
		var factor = curt + 50.0
		factor /= 30.0
		colm = mix( colors_mid[-50],  colors_mid[-20], factor)
	
	if val == -1000:
		color_mid = colm
	return colm

func get_color_dark(val = -1000):
	var curt = 0
	if val == -1000:
		current_temp = clamp(current_temp,-50,100)
		curt = current_temp
	else:
		val = clamp(val,-50,100)
		curt = val
	var cold
	if curt >= 70:
		var factor = curt - 70.0
		factor /= 30.0
		cold = mix( colors_dark[70],  colors_dark[100], factor)
	elif curt >= 40:
		var factor = curt - 40.0
		factor /= 30.0
		cold = mix( colors_dark[40],  colors_dark[70], factor)
	elif curt >= 20:
		var factor = curt - 20.0
		factor /= 20.0
		cold = mix( colors_dark[20],  colors_dark[40], factor)
	elif curt >= 0:
		var factor = curt
		factor /= 20.0
		cold = mix( colors_dark[0],  colors_dark[20], factor)
	elif curt >= -20:
		var factor = curt + 20.0
		factor /= 20.0
		cold = mix( colors_dark[-20],  colors_dark[0], factor)
	else:
		var factor = curt + 50.0
		factor /= 30.0
		cold = mix( colors_dark[-50],  colors_dark[-20], factor)
	
	if val == -1000:
		color_dark = cold
	return cold
