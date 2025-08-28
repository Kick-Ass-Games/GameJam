extends Node2D

@export var width: float = 10
@export var height: float = 10

func _ready():
	add_to_group("zonas_spawn")

func get_random_position() -> Vector2:
	var half_w = width / 2
	var half_h = height / 2
	var local_x = randf_range(-half_w, half_w)
	var local_y = randf_range(-half_h, half_h)
	return position + Vector2(local_x, local_y)
