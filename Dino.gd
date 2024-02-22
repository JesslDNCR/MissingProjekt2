extends CharacterBody2D
signal health_depleted
var health = 100.0
var speed = 600
var run = 800
var dashSpeed = 1800
var dashDuration = 0.2
@onready var dash = $Dash
var direction
const GUN = preload("res://gun.tscn")
const SWORD = preload("res://Sword.tscn")
var invulnerable = false
var switch: bool = true
func _ready():
	var sword = SWORD.instantiate()
	add_child(sword)
func _input(event):
	#if Input.is_action_just_pressed("1"):
	#	if has_node("Sword"):
	#		get_node("Sword").queue_free()
	#	if not has_node("Gun"):
	#		var gun = GUN.instantiate()
	#		add_child(gun)
	#if Input.is_action_just_pressed("2"):
	#	if has_node("Gun"):
	#		get_node("Gun").queue_free()
	#	if not has_node("Sword"):
	#		var sword = SWORD.instantiate()
	#		add_child(sword)
	if Input.is_action_just_pressed("move_left"):
		if switch:
			%Animation.scale.x *=-1
			switch = false
	if Input.is_action_just_pressed("move_right"):
		if not switch:
			%Animation.scale.x *=-1
			switch = true
	if Input.is_action_just_pressed("dash"):
		if dash.canDash and not dash.isDashing():
			dash.startDash(dashDuration,%Animation.scale.x)
			collision_mask = 0
			collision_layer = 0
			invulnerable = true
		
func add_health():
	if health+3<100:
		health +=3
	else:
		health = 100
	%ProgressBar.value = health

func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if Input.is_action_pressed("sprint"):
		velocity = direction*run
	else:
		velocity = direction*dashSpeed if dash.isDashing() else direction*speed
	
	move_and_slide()
	if invulnerable and not dash.isDashing():
		collision_mask = 1
		collision_layer = 1
		
	if velocity.length()>0.0:
		if Input.is_action_pressed("sprint") or dash.isDashing():
			%Animation.play("Run")
		#get_node("HappyBoo").play_walk_animation()
		else:
			%Animation.play("Walk")
	else:
		#get_node("HappyBoo").play_idle_animation()
		%Animation.play("Idle")
		
	const DAMAGE_RATE = 12.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0 and not dash.isDashing():
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		%Animation.play("TakeDMG")
		if health <= 0.0:
			health_depleted.emit()
			
