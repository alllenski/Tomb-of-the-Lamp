extends Entity
class_name Djinn
	
@export_enum("left", "right", "down", "up") var direction : String = "left"

@onready var sprite = $AnimatedSprite

var is_stunned := false

func act():
	if is_stunned:
		sprite.play("spooked")
		is_stunned = false
		return
	sprite.play("default")
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


func pull(target_position : Vector2):
	var puff = puff_scene.instantiate()
	puff.global_position = global_position
	Globals.level.effects.add_child(puff)
	var movement := target_position - position
	movement = movement.normalized()
	global_position += movement * tile_size
	is_stunned = true
	

func unsummon():
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	Globals.level.effects.add_child(explosion)
	queue_free()
