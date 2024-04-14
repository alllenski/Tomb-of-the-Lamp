extends Node

@onready var music = $MusicPlayer
@onready var sfx = $SFXPlayer

var level

var exiting = false

var config = ConfigFile.new()

func _ready():
	pass
	#var config = ConfigFile.new()
#
	#var err = config.load("user://config.cfg")
#
	#if err != OK:
		#return

	# Settings (if has time D:)	
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
			#linear2db(config.get_value("Audio", "Master", 0.5)));
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),
			#linear2db(config.get_value("Audio", "Music", 0.5)));
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),
			#linear2db(config.get_value("Audio", "Effects", 0.5)));

