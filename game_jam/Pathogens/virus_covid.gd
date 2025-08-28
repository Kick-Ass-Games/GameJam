extends Area2D

@export var swim_speed := 50.0
var heartbeat_push := 0.0

signal virus_eaten  # Emitted when slime touches it

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	var parent = get_parent()
	if parent.has_signal("beat"):
		parent.connect("beat", Callable(self, "_on_heart_beat"))

func _physics_process(delta):
	position.x += heartbeat_push * swim_speed * delta

func _on_heart_beat(value: float):
	heartbeat_push = value

func _on_body_entered(body):
	if body.name == "Slime":
		print("🦠 Virus touched by Slime!")
		emit_signal("virus_eaten")
		queue_free()
