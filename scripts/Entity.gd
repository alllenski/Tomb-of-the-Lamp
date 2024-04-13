class_name Entity
extends Area2D

@onready var ray_cast = $RayCast2D

@export var is_pushable = false

@export_multiline var dialogue : String

var move_priority := 0

var tile_size = 16
var directions = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN,}

var history := []
			

func check(direction):
	ray_cast.target_position = directions[direction] * tile_size
	ray_cast.force_raycast_update()
	if !ray_cast.is_colliding():
		return true
	else:
		var collider = ray_cast.get_collider()
		if collider.name == "Walls":
			return false
		if collider.is_pushable and collider.check(direction):
			collider.move(direction)
			return true
		else:
			return false
			
			
func move(direction):
	global_position += directions[direction] * tile_size
	
	
func reverse():
	if history.size() == 0:
		return
	var previous_position = global_position
	global_position = history.pop_back()
	

func record():
	history.append(global_position)
