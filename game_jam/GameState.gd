extends Node

func _process(delta):
	if GameTime
		restart_game()

func restart_game():
	get_tree().reload_current_scene()
