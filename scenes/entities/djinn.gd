extends Entity
	
var direction : String


func _ready():
	direction = "ui_left"


func act():
	if check(direction):
		move(direction)
	else:
		flip()
		if check(direction):
			move(direction)
		

func flip():
	if direction == "ui_left":
		direction = "ui_right"
	elif direction == "ui_right":
		direction = "ui_left"
	elif direction == "ui_up":
		direction = "ui_down"
	elif direction == "ui_down":
		direction = "ui_up"
		
		
func move(direction):
	super.move(direction)
	# move_sound.play()

	
