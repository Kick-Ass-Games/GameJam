extends Node2D

func _ready():
	$Background_1.visible = true
	$Background_2.visible = false
	$Background_3.visible = false
	start_time = Time.get_ticks_msec()

var linternaActivada = false
var timer_duration = 5  # 5 minutos = 300 segundos
var start_time = 0
var light = 0

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		light += 1
		toggle_linterna()

func toggle_linterna():
	if light == 0:
		$Background_1.visible = true
		$Background_2.visible = false 
		$Background_3.visible = false
	if light == 1:
		$Background_1.visible = false
		$Background_2.visible = true
		$Background_3.visible = false
	if light == 2:
		$Background_1.visible = false
		$Background_2.visible = false
		$Background_3.visible = true
	if light == 3:
		light = 0 
		toggle_linterna()
		
	print(light) 
