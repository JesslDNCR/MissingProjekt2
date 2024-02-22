extends Node2D

@onready var durationTimer = $DurationTimer
@onready var dashDelay = $DashDelay
const GHOST = preload("res://DashGhost.tscn")
var canDash = true
var dashDelayTime = 0.6
var direction
var count = 0
func startDash(duration:float,direction):
	if canDash and !isDashing():
		self.direction = direction
		durationTimer.wait_time = duration
		durationTimer.start()
		
func isDashing():
	return !durationTimer.is_stopped()
func _physics_process(delta):
	count+=delta
	if count>0.02:
		count = 0
		if isDashing():
			instanceGhost()
		
func instanceGhost():
	var ghost = GHOST.instantiate()
	ghost.scale.x = direction
	ghost.global_position = global_position
	get_node("/root/Game").add_child(ghost)
	
func endDash():
	canDash = false
	dashDelay.wait_time = dashDelayTime
	dashDelay.start()
	

func _on_dash_delay_timeout():
	canDash = true

