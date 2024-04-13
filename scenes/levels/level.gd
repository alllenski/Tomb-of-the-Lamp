extends Node


@onready var transition = $Transition
@onready var player = $"%Player"

@export var next_level_path : String

@export var music := ""

var ending := false


func _ready():
	Globals.level = self
	# Globals.music.play(music)
	transition.material.set_shader_parameter("cutoff", 0.0)
	transition.material.set_shader_parameter("mask", load("res://masks/mask_lift.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.6)


func set_shader_value(value: float):
	# thx internet
	transition.material.set_shader_parameter("cutoff", value)
	
	
func _input(event):
	#if event.is_action_released("restart"):
		#ending = true
		#get_tree().reload_current_scene()
	if event.is_action_released("reverse"):
		if not ending:
			get_tree().call_group("Entities", "reverse")
	

func next_level():
	ending = true
	# await get_tree().create_timer(1.5).timeout
	# Globals.sfx.play("VictoryJingle")
	transition.material.set_shader_parameter("mask", load("res://masks/mask_drop.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.6)
	tween.tween_callback(change_scene)
	
	
func change_scene():
	if next_level_path:
		get_tree().change_scene(next_level_path)
	else:
		get_tree().reload_current_scene()
