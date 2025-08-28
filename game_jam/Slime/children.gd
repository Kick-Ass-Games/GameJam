extends CharacterBody2D

@export var speed := 100.0
@export var player: Node2D
@export var heartbeat_force := 0.5

var heartbeat_push := 0.0
@onready var timer := $Timer

func _ready():
	if not player:
		push_warning("❗ Player not assigned to child!")

	# Connect to HeartPump signal
	var heart_pump := get_parent()
	if heart_pump and heart_pump.has_signal("beat"):
		heart_pump.connect("beat", Callable(self, "_on_heart_beat"))
	else:
		push_warning("❗ No HeartPump or beat signal found.")

	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _physics_process(_delta):
	if player:
		var to_player := player.global_position - global_position
		var dist := to_player.length()

		var dir := to_player.normalized()
		var over_under := 1 if dist >= 420 else -1
		velocity = dir * speed * over_under
		velocity.x += heartbeat_push * heartbeat_force * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _on_heart_beat(val: float) -> void:
	heartbeat_push = val

func _on_timer_timeout():
	pass  # Optional for future behavior
