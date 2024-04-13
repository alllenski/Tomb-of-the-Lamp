extends Entity

@export var buttons : Array[Node]

var is_open := true

var just_entered = false


func _ready():
	if buttons:
		for button in buttons:
			button.pressed.connect(check_buttons)
			button.released.connect(check_buttons)
		check_buttons()

#func _notification(what):
	#if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		#monitoring = false

func _on_area_entered(area):
	await get_tree().physics_frame
	check_buttons()
	if area.name == "Player" and is_open:
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


func check_buttons():
	var amount := 0
	for button in buttons:
		if button.is_pressed:
			amount += 1
	if amount == buttons.size():
		show()
		monitoring = true
		is_open = true
	else:
		hide()
		monitoring = false
		is_open = false
		
		
