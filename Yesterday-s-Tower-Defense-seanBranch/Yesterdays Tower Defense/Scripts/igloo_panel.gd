extends Panel

@onready var tower = preload("res://Scenes/towers/ninja_tower.tscn")
var currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)

		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		
		tempTower.scale = Vector2(0.32,0.32)
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position

	elif event is InputEventMouseButton and event.button_mask == 0:
		if get_child_count() > 1:
			get_child(1).queue_free()
		
		var path = get_tree().get_root().get_node("Main/Towers")
		
		path.add_child(tempTower)
		tempTower.global_position = event.global_position
		
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()


func _on_pause_play_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true

	# Force the button to update its visual state







