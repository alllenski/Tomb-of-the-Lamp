extends Entity


var just_entered = false


#func _notification(what):
	#if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		#monitoring = false

func _on_area_entered(area):
	if area.name == "Player":
		Globals.level.next_level()
	#on_sound.play()
	#$AnimatedSprite.visible = false
	#$AnimatedSprite/Particles2D.emitting = false
	just_entered = true
	await get_tree().physics_frame
	just_entered = false


func _on_area_exited(area):
	if just_entered:
		return
	#$AnimatedSprite.visible = true
	#$AnimatedSprite/Particles2D.emitting = true
