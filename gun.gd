extends Area2D

const BULLET = preload("res://bullet.tscn")
var in_range = false
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		in_range = true
		var target_enemy = enemies_in_range.front()
		#var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
		if global_rotation>1.6 or global_rotation<-1.6:
			scale.y = -1
		else:
			scale.y = 1
	else:
		in_range = false
func shoot():
	if in_range:
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()
