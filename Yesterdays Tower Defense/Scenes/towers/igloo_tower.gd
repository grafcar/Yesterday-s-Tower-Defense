extends StaticBody2D

var Bullet = preload("res://Scenes/towers/snowball.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr
var firingTimer
var fireRate = 1.0  # Adjust this value to change the fire rate (in seconds)


func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

func _on_tower_body_entered(body):
	call_deferred("_process_on_tower_body_entered", body)

func _process_on_tower_body_entered(body):
	if "enemyDrone" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		for i in currTargets:
			if "enemyDrone" in i.name:
				tempArray.append(i)
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
					
		curr = currTarget
		pathName = currTarget.get_parent().name
		
		self.look_at(curr.global_position)
		
		call_deferred("_generate_bullet", pathName)

func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()

func _generate_bullet(pN):
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pN
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
