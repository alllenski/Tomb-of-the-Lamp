extends Node

func play(sfx = null):
	if sfx:
		get_node(sfx).play()
	else:
		print("No sfx passed.")
		
func stop(sfx = null):
	if sfx:
		get_node(sfx).stop()
	else:
		print("No sfx passed.")
