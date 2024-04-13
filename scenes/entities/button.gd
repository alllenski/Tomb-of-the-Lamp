extends Entity

signal pressed 
signal released

@onready var sprite := $AnimatedSprite

var just_entered = false

var is_pressed := false

#func _notification(what):
	#if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		#monitoring = false

func _on_area_entered(area):
	is_pressed = true
	if not just_entered:
		pressed.emit()
		sprite.play("pressed")
	#on_sound.play()
	#$AnimatedSprite.visible = false
	#$AnimatedSprite/Particles2D.emitting = false
	just_entered = true
	await get_tree().physics_frame
	just_entered = false


func _on_area_exited(area):
	if just_entered:
		return
	sprite.play("default")
	is_pressed = false
	released.emit()
