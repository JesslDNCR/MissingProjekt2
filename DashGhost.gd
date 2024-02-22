extends Sprite2D

func _ready():
	var tween:Tween = create_tween().bind_node(self)
	tween.tween_property(self,"modulate:a", 0.0,0.4).from(0.5)
	tween.play()
	tween.finished.connect(finished)
func finished():
	queue_free()
