extends StaticBody2D

var Bullet = preload("res://Scenes/towers/shuriken.tscn")
var bulletDamage = 2.5
var pathName
var currTargets = []
var curr
var fireRate = 0.3  # Adjust this value to change the fire rate (in seconds)
var firing = false
var loaded = true
var bulletTimer
@onready var anim = $ninjaAnimated

func _ready():
	bulletTimer = get_node("FiringTimer")
	bulletTimer.wait_time = fireRate
	anim.play("default")

func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		firing = true
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
		stopFiring()
		
	if firing and loaded:
		call_deferred("_generate_bullet")
		loaded = false
		bulletTimer.start()

func updateCurrentTarget():
	if currTargets.is_empty():
		curr = null
	else:
		var furthestEnemy = null
		var furthestProgress = -1e10 #Very large negative number
		
		for target in currTargets:
			if target.name == "enemyDrone":
				var progress = target.get_parent().get_progress()
				if progress > furthestProgress:
					furthestEnemy = target
					furthestProgress = progress
					
		if furthestEnemy:
			curr = furthestEnemy
			pathName = furthestEnemy.get_parent().name

func _on_tower_body_entered(body):
	call_deferred("_process_on_tower_body_entered", body)
	
func _on_tower_body_exited(body):
	call_deferred("_process_on_tower_body_exited", body)

func _process_on_tower_body_entered(body):
	if body.name == "enemyDrone":
		currTargets.append(body)
		updateCurrentTarget()

func _process_on_tower_body_exited(body):
	currTargets.erase(body)
	updateCurrentTarget()

func _generate_bullet():
	var tempBullet = Bullet.instantiate()
	tempBullet.bulletDamage = bulletDamage
	tempBullet.global_position = $Aim.global_position
	tempBullet.target = curr
	get_node("BulletContainer").add_child(tempBullet)
	
func stopFiring():
	firing = false

func _on_BulletTimer_timeout():
	loaded = true


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Main/Towers")
		for i in towerPath.get_child_count():
			get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
			get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-230, 60)
