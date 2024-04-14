extends Node


@onready var transition = $Transition
@onready var player = $"%Player"
@onready var entities = $World/Entities
@onready var effects = $World/Effects

@onready var dialogue = $Dialogue

@export var next_level_path : String

@export var music := "Main"

var ending := false

var text_cancelled := false

func _ready():
	Globals.level = self
	Globals.music.play(music)
	Globals.sfx.play("Restart")
	transition.material.set_shader_parameter("cutoff", 0.0)
	transition.material.set_shader_parameter("mask", load("res://masks/mask_lift.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.6)


func set_shader_value(value: float):
	transition.material.set_shader_parameter("cutoff", value)
	
	
func _input(event):
	if event.is_action_released("restart"):
		ending = true
		get_tree().reload_current_scene()
	# Borked because doesn't record spawning / destroying
	#if event.is_action_released("reverse"):
		#if not ending:
			#get_tree().call_group("Entities", "reverse")
	

func next_level():
	ending = true
	transition.material.set_shader_parameter("mask", load("res://masks/mask_drop.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.6)
	tween.tween_callback(change_scene)
	
	
func change_scene():
	if next_level_path:
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().reload_current_scene()


func display_text(_text : String):
	var length = _text.length()
	for i in length:
		dialogue.text = "[shake rate=10.0 level=3 connected=1][center]%s[/center][/shake]" % _text.left(i + 1)
		Globals.sfx.play("Type")
		await get_tree().create_timer(0.2).timeout
	for i in length:
		dialogue.text = "[shake rate=10.0 level=3 connected=1][center]%s[/center][/shake]" % _text.right(length - i)
		Globals.sfx.play("Type")
		await get_tree().create_timer(0.2).timeout
	dialogue.clear()


func show_image():
	player.is_controllable = false
	transition.material.set_shader_parameter("cutoff", 1.0)
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_close.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.6)
	await tween.finished
	$ImageScene.show()
	$World/Entities/Lamp.queue_free()
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_open.png"))
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.6)
	await tween.finished
	Globals.sfx.play("LampGet")
	await get_tree().create_timer(4.0).timeout
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_close.png"))
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.6)
	await tween.finished
	$ImageScene.hide()
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_open.png"))
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.6)
	await tween.finished
	player.is_controllable = true
