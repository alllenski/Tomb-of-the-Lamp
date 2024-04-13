extends Entity
	
@export_enum("left", "right", "down", "up") var direction : String = "left"
@export var explosion_scene : PackedScene

func act():
	if check(direction):
		move(direction)
	else:
		flip()
		if check(direction):
			move(direction)
		

func flip():
	if direction == "left":
		direction = "right"
	elif direction == "right":
		direction = "left"
	elif direction == "up":
		direction = "down"
	elif direction == "down":
		direction = "up"
		
		
func move(direction):
	super.move(direction)
	# move_sound.play()


func resolve():
	ray_cast.target_position = directions[direction]
	ray_cast.hit_from_inside = true
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		Globals.level.effects.add_child(explosion)
		queue_free()
	ray_cast.hit_from_inside = false

