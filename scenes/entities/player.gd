extends Entity
	
@onready var sprite = $AnimatedSprite
@onready var halo_sprite = $HaloSprite
# @onready var move_sound = $MoveSound
# @onready var fail_move_sound = $FailMoveSound

@export var djinn_scene : PackedScene
@export var has_lamp := false	
	
var has_ghost := false
	
var time := 0.0	

var is_controllable = true


func _ready():
	if has_lamp:
		halo_sprite.show()
	else:
		halo_sprite.hide()


func _unhandled_input(event):
	if not is_controllable:
		return
	if event.is_action_released("wait"):
		get_tree().call_group("Entities", "act")
		return
	if event.is_action_released("action"):
		if interact(sprite.animation):
			get_tree().call_group("Entities", "act")
			await get_tree().physics_frame
			get_tree().call_group("Entities", "resolve")
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
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is TileMap:
			pass
		elif collider is Djinn and not has_ghost and has_lamp:
			collider.unsummon()
			regain_ghost()
			return true
		elif collider.dialogue == null:
			talk(collider.dialogue)
			return true
	if has_lamp:
		ray_cast.target_position = directions[direction] * tile_size * 16
		ray_cast.set_collision_mask(pow(2, 2-1))
		print(ray_cast.get_collision_mask())
		ray_cast.force_raycast_update()
		ray_cast.collision_mask = 1
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			if collider is Djinn:
				collider.pull(position)
				return true
	return false
	

func talk(dialogue):
	print(dialogue)


func summon():
	has_ghost = false
	
	
func regain_ghost():
	has_ghost = true
	halo_sprite.show()
			
