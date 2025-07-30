extends Node

func _process(delta):
	#if GameTimer.is_time_up():
		restart_game()

func restart_game():
	get_tree().reload_current_scene()
