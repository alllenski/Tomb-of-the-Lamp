extends Node

func play(music = null):
	if music:
		var _music = get_node(music)
		if not _music.playing:
			get_node(music).play()
	else:
		print("No music passed.")
		
func stop(music = null):
	if music:
		get_node(music).stop()
	else:
		print("No music passed.")
