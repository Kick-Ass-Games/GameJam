extends Node

var timer_duration = 300  # 5 minutos = 300 segundos
var start_time = 0

func _ready():
	start_time = Time.get_ticks_msec()

func get_time_remaining():
	var elapsed = (Time.get_ticks_msec() - start_time) / 1000.0
	return max(0, timer_duration - elapsed)

func is_time_up():
	return get_time_remaining() <= 0
