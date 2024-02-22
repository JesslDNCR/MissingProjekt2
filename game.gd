extends Node2D

const ENEMY = preload("res://enemy.tscn")
const ENEMY_Chicken = preload("res://Chicken.tscn")
const BOSS = preload("res://pumpkin.tscn")
var spawned:bool = false
var rng = RandomNumberGenerator.new()
@onready var slime_count = get_node("/root/Game/KillCounter/Control/Slime_label")
@onready var chicken_count = get_node("/root/Game/KillCounter/Control/Chicken_label")
var decone = false
var dectwo = false
func spawn_mob():
		%PathFollow2D.progress_ratio = randf()
		var new_mob
		#slime_count.getCount()
		#print(slime_count.getCount())
		if slime_count.getCount()<21:
			new_mob = ENEMY.instantiate()
		else:
			if not decone:
				%Timer.wait_time = 0.8
				decone = true
			var my_random_number = rng.randi_range(0, 10)
			if my_random_number%2==0:			
				new_mob = ENEMY.instantiate()
			else:
				new_mob = ENEMY_Chicken.instantiate()
		new_mob.global_position = %PathFollow2D.global_position
		add_child(new_mob)
		if slime_count.getCount()>39 and chicken_count.getCount()>19 and not spawned:
			if not dectwo:
				%Timer.wait_time = 0.5
				dectwo = true
			var boss = BOSS.instantiate()
			%PathFollow2D.progress_ratio = randf()
			boss.global_position = %PathFollow2D.global_position
			add_child(boss)
			spawned = true
func _on_timer_timeout():
	spawn_mob()

func _on_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
