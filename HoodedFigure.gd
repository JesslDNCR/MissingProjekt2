extends CharacterBody2D

var animation
var canTalk = false
@onready var interaction = get_node("../Interaction")
func _ready():
	animation = get_node("Animation")
	animation.play("Idle")
func _input(event):
	if Input.is_action_just_pressed("interact") and canTalk:
		get_tree().paused = true
		#get_node("/root/Game/KillCounter/Control/Slime_label").decCount(10)
		get_node("/root/Game/Talk").visible = true
		get_node("/root/Game/Talk").printText()
func _physics_process(delta):
	if get_tree().paused:
		animation.pause()
	else:
		animation.play()
	var dino = get_node("/root/Game/Dino")
	var direction = global_position-dino.global_position
	if direction.x>0:
		%Animation.scale.x = -4
	else: 
		%Animation.scale.x = 4


func _on_area_2d_body_entered(body):
	if body.name == "Dino":
		canTalk = true
		interaction.visible = true

func _on_area_2d_body_exited(body):
	if body.name=="Dino":
		canTalk = false
		interaction.visible = false

