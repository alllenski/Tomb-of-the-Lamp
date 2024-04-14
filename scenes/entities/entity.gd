class_name Entity
extends Area2D

@onready var ray_cast := $RayCast2D

@export var is_pushable := false
@export var is_explosive := false

var explosion_scene = preload("res://scenes/effects/explosion.tscn")
var puff_scene = preload("res://scenes/effects/puff.tscn")



@export_multiline var dialogue := ""

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
		elif collider.name == "Holes":
			if is_pushable:
				return true
		elif collider.is_pushable and collider.check(direction):
			collider.move(direction)
			return true
		else:
			return false
			
			
func move(direction):
	var puff = puff_scene.instantiate()
	puff.global_position = global_position
	Globals.level.effects.add_child(puff)
	global_position += directions[direction] * tile_size
	
	
func reverse():
	if history.size() == 0:
		return
	var previous_position = global_position
	global_position = history.pop_back()
	

func record():
	history.append(global_position)


func resolve():
	if not is_explosive:
		return
	ray_cast.target_position = Vector2.ONE
	ray_cast.hit_from_inside = true
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.name == "Holes":
			pass
		elif not collider.is_explosive:
			return
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		Globals.level.effects.add_child(explosion)
		Globals.sfx.play("Explosion")
		queue_free()
	ray_cast.hit_from_inside = false
