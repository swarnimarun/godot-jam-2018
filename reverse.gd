extends Sprite

var norm = false

func _ready():
	if not norm:
		self_modulate = Color(0.0,0.0,0.0,1.0)

func _process(delta):
	rotate(delta*4.0)

func destroy():
	Data.normal = not norm
	get_parent().remove_child(self)
	self.call_deferred("free")