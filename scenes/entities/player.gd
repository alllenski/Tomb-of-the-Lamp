extends Entity
	
@onready var sprite = $AnimatedSprite
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
				await get_tree().physics_frame
				get_tree().call_group("Entities", "resolve")
			else:
				fail_move(direction)
		
		
func move(direction):
	super.move(direction)
	sprite.play(direction)
	# move_sound.play()
	
	
func fail_move(direction):
	# fail_move_sound.play()
	pass


func interact(direction):
	ray_cast.target_position = directions[direction] * tile_size
	ray_cast.force_raycast_update()
	if !ray_cast.is_colliding():
		return false
	else:
		var collider = ray_cast.get_collider()
		if collider.dialogue:
			print(collider.dialogue)
			return true
		else:
			return false
			
