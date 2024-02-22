extends CanvasLayer

@onready var pauseMenu = get_node("../PauseMenu")
@onready var talk = get_node("../Talk")
func _input(event):
	if Input.is_action_just_pressed("Escape"):
		if not get_tree().paused:
			get_tree().paused = true
			pauseMenu.visible = true
		else:
			if talk.visible:
				talk.visible = false
			get_tree().paused = false
			pauseMenu.visible = false
