extends Label

var count:int = 0
func _ready():
	text = "Killed: 0"
func inc():
	count+=1
	text = "Killed: "+str(count)
func getCount():
	return count

func decCount(amount:int):
	if count>=amount:
		count-=amount
		text = "Killed: "+str(count)
