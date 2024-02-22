extends CharacterBody2D

@onready var player = get_node("/root/Game/Dino")
@onready var label = get_node("/root/Game/KillCounter/Control/Chicken_label")
const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
var health = 4
var count = 0
var can_dmg = true
func _ready():
	%Animation.play("Walk")
func _physics_process(_delta):
	if count == 0:
		var direction = player.global_position-global_position
		#var direction = global_position.direction_to(player.global_position)
		velocity = direction.normalized()*200
		if velocity.x<0:
			%Animation.scale.x = -5
		else:
			%Animation.scale.x = 5
	else:
		count-=1
	move_and_slide()

func take_damage(meele:bool,dmg:float):
	if can_dmg:
		#can_dmg = false
		#%Timer.start(0.1)
		#%Slime.play_hurt()
		health-=dmg
		if health <=0:
			player.add_health()
			label.inc()
			queue_free()
			var smoke = SMOKE.instantiate()
			get_parent().add_child(smoke)
			smoke.global_position = global_position
		else:
			var dir =global_position-player.global_position
			if meele:
				velocity = dir.normalized()*400
				count = 16
			else:
				velocity = dir.normalized()*200
				count = 7
				


func _on_timer_timeout():
	can_dmg = true
