extends CharacterBody2D

var target
var Speed = 1000
var bulletDamage = 10

func _physics_process(delta):
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.global_position) * Speed
		look_at(target.global_position)
		move_and_slide()
	else:
		queue_free()

func set_target(new_target):
	target = new_target

func _on_area_2d_body_entered(body):
	if "enemyDrone" in body.name:
		body.Health -= bulletDamage
		queue_free()
