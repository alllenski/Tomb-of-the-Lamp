extends Node


@onready var transition = $Transition

@export var next_level_path : String

var is_ending := false

func _ready():
	transition.material.set_shader_parameter("cutoff", 1.0)
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_open.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.6)


func set_shader_value(value: float):
	# thx internet
	transition.material.set_shader_parameter("cutoff", value)
	
	
func _input(event):
	if event is InputEventKey:
		if not is_ending:
			next_level()
	

func next_level():
	is_ending = true
	# Globals.sfx.play("VictoryJingle")
	transition.material.set_shader_parameter("cutoff", 1.0)
	transition.material.set_shader_parameter("mask", load("res://masks/mask_radial_open.png"))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.6)
	tween.tween_callback(change_scene)
	
	
func change_scene():
	if next_level_path:
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().reload_current_scene()
