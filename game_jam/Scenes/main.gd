extends Node2D

var linternaActivada = false
var timer_duration = 300  # 5 minutos en segundos 300s
var light = 0
var start_time = 0

func _ready():
	$Background_1.visible = true
	$Background_2.visible = false
	$Background_3.visible = false
	start_time = Time.get_ticks_msec()

func _process(delta):
	if is_time_up():
		restart_game()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		light += 1
		toggle_linterna()

func toggle_linterna():
	if light == 0:
		$Background_1.visible = true
		$Background_2.visible = false 
		$Background_3.visible = false
	elif light == 1:
		$Background_1.visible = false
		$Background_2.visible = true
		$Background_3.visible = false
	elif light == 2:
		$Background_1.visible = false
		$Background_2.visible = false
		$Background_3.visible = true
	elif light == 3:
		light = 0 
		toggle_linterna()

func get_time_remaining():
	var elapsed = (Time.get_ticks_msec() - start_time) / 1000.0
	return max(0, timer_duration - elapsed)

func is_time_up():
	return get_time_remaining() <= 0

func restart_game():
	get_tree().reload_current_scene()
