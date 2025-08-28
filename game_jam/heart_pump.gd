extends Node2D

signal beat(value: float)

@export var beat_strengths := [22.0, 0.0, -5.0, 0.0] # ← Right, Left, Right, Neutral
@export var beat_durations := [0.5, 0.2, 0.1, 0.2]  # ← Seconds per beat

var current_beat := 0
var timer := 0.0

func _ready():
	print("❤️ HeartPump initialized.")
	start_beat(current_beat)

func _physics_process(delta):
	timer -= delta
	if timer <= 0.0:
		current_beat = (current_beat + 1) % beat_strengths.size()
		start_beat(current_beat)

func start_beat(index: int):
	var strength = beat_strengths[index]
	var duration = beat_durations[index]
	#print("🫀 Beat ", index + 1, " | Strength: ", strength, " | Duration: ", duration)

	emit_signal("beat", strength)
	timer = duration
