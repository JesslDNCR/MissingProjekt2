extends Node2D
var left :bool = false
const SWING = preload("res://SwordSwing.tscn")
func _physics_process(delta):
	if not $AnimationPlayer.is_playing():
		look_at(get_global_mouse_position())
	if Input.is_action_pressed("attack") and not $AnimationPlayer.is_playing():
		for b in %Area2D.get_overlapping_bodies():
			if b.has_method("take_damage"):
				b.take_damage(true,2)
				pass
		if left:
			%AnimationPlayer.play("SwordSwing_left")
			left = false
		else:
			%AnimationPlayer.play("SwordSwing_right")
			left = true

func _input(event):
	pass

func _on_body_entered(body):
	if Input.is_action_pressed("attack"):
		if body.has_method("take_damage"):
			body.take_damage(true,2)

func draw_Swing():
	var new_Swing = SWING.instantiate()
	new_Swing.global_position = %Area2D.global_position
	new_Swing.look_at(get_global_mouse_position())
	#print(new_Swing.global_position," ",global_position," ",new_Swing.global_rotation)
	get_node("/root/Game").add_child(new_Swing)
