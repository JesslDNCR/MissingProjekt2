extends CanvasLayer

var down = true
@onready var enter = get_node("Panel/Enter-taste")
@onready var label = get_node("Panel/Label")
@onready var interaction = get_node("../Interaction")
var newText = false
var text:String 
var count = 0
var loadingNextText = false
var blinkEnter = false
var Tcount:int = 0
var defeated = false
var enterAgain= false
func _input(event):
	if enterAgain and Input.is_action_just_pressed("enter") and visible :
		enterAgain = false
		enter.modulate.a = 0
		newText = true
		label.text = ""
		blinkEnter = false
		print(Tcount)
		if Tcount>3:
			get_tree().paused = false
			visible=false
			interaction.visible = true
			if not defeated:
				%Time.start()
				%Timer.start()
			if defeated:
				%Time.stop()
func _physics_process(delta):
	if loadingNextText:
		if Tcount==0:
			text = "Greetings little dino can you by chance defeat those creatures surrounding us?"
		if Tcount==1:
			text = "By doing so will summon the evil Pumpkin make him gone as well!"
		elif Tcount==2:
			text = "now do it!!!!!!!"
		Tcount+=1
		if defeated:
			text = "Thanks dino much appreciated"
			Tcount = 6
		loadingNextText = false
	if newText:
		count+=delta
		if text.length()>0 and count>0.008:
			count=0
			label.text=label.text+text.left(1)
			text = text.right(text.length()-1)
		else:
			newText = false
			loadingNextText = true
			blinkEnter = true
			enter.modulate.a = 1
			down = true
			enterAgain = true
	if blinkEnter:
		if enter.modulate.a>1:
			down = true
		elif enter.modulate.a<0:
			down = false
		if down:
			enter.modulate.a-=0.008
		else:
			enter.modulate.a+=0.006

func printText():
	interaction.visible = false
	loadingNextText = true
	enter.modulate.a = 0
	newText = true
	label.text = ""
	Tcount = 0
	enterAgain = false
	
func defeted():
	defeated = true
