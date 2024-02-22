extends CharacterBody2D
signal health_depleted
var health = 100.0
var speed = 600
var direction
const GUN = preload("res://gun.tscn")
const SWORD = preload("res://Sword.tscn")
func _input(event):
	if Input.is_action_just_pressed("dash"):
		position += direction*150
	if Input.is_action_just_pressed("1"):
		if has_node("Sword"):
			get_node("Sword").queue_free()
		if not has_node("Gun"):
			var gun = GUN.instantiate()
			add_child(gun)
	if Input.is_action_just_pressed("2"):
		if has_node("Gun"):
			get_node("Gun").queue_free()
		if not has_node("Sword"):
			var sword = SWORD.instantiate()
			add_child(sword)
func add_health():
	if health+10<100:
		health +=10
	else:
		health = 100
	%ProgressBar.value = health
func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction*speed
	
	move_and_slide()
	if velocity.length()>0.0:
		#get_node("HappyBoo").play_walk_animation()
		%HappyBoo.play_walk_animation()
	else:
		#get_node("HappyBoo").play_idle_animation()
		%HappyBoo.play_idle_animation()
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
