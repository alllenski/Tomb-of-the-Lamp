extends Entity
	
# @onready var move_sound = $MoveSound
# @onready var fail_move_sound = $FailMoveSound
	
var time := 0.0	

var is_controllable = true


func _unhandled_input(event):
	if not is_controllable:
		return
	if event.is_action_released("wait"):
		get_tree().call_group("Entities", "act")
		return
	if event.is_action_released("action"):
		get_tree().call_group("Entities", "act")
		return
	for direction in directions.keys():
		if event.is_action_released(direction):
			get_tree().call_group("Entities", "record")
			if check(direction):
				move(direction)
				await get_tree().physics_frame
				get_tree().call_group("Entities", "act")
			else:
				fail_move(direction)
		
		
func move(direction):
	super.move(direction)
	# move_sound.play()
	
	
func fail_move(direction):
	# fail_move_sound.play()
	pass
