extends Label

var mil:int = 0
var sec:int = 0
var min:int = 0
var run:bool = false
func _physics_process(delta):
	if run:
		mil+=1
		if mil>=100:
			mil=0
			sec += 1
		if sec>59:
			sec = 0
			min += 1
		var s_mil:String = str(mil)
		if mil<10:
			s_mil = "0"+str(mil)
		var s_sec:String = str(sec)
		if sec<10:
			s_sec = "0"+str(sec)
		if min!=0:
			text = str(min)+":"+str(s_sec)+":"+str(s_mil)
		else:
			text = str(s_sec)+":"+str(s_mil)

func start():
	run = true
func stop():
	run = false
