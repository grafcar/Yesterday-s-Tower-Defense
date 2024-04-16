extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_pause_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var tree = get_tree()
	# Toggle pause state
	tree.set_pause(!tree.is_paused())
