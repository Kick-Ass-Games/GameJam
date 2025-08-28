extends CharacterBody2D

@export var movement_speed := 500.0
@export var heartbeat_force := 50
@export var children_scene: PackedScene

var heartbeat_push := 0.0
var VP: int = 0

func _ready():
	print("🧬 Slime ready!")

	var heart_pump = get_parent()
	if heart_pump and heart_pump.has_signal("beat"):
		heart_pump.connect("beat", Callable(self, "_on_heart_beat"))
	else:
		push_warning("Slime could not find beat signal in parent!")

	if $HitBox:
		$HitBox.connect("area_entered", Callable(self, "_on_hitbox_area_entered"))
	else:
		push_warning("HitBox node not found!")

func _physics_process(_delta):
	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("Left"):
		input_dir.x -= 1
	if Input.is_action_pressed("Right"):
		input_dir.x += 1
	if Input.is_action_pressed("Up"):
		input_dir.y -= 1
	if Input.is_action_pressed("Down"):
		input_dir.y += 1

	velocity = input_dir.normalized() * movement_speed
	velocity.x += heartbeat_push * heartbeat_force

	move_and_slide()


func _on_heart_beat(val: float):
	heartbeat_push = val

func _on_hitbox_area_entered(area):
	if area.is_in_group("Virus"):
		VP += 1
		print("🦠 Virus eaten! VP =", VP)
		update_blue_tint()
		area.queue_free()

		if VP >= 10:
			cell_division()
			VP = 0
			update_blue_tint()

func update_blue_tint():
	var vp_ratio: float = clamp(float(VP) / 10.0, 0.0, 1.0)
	var mat := $Sprite2D.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("vp", vp_ratio)
		print("🎨 Shader 'vp' updated to:", vp_ratio)

func cell_division():
	print("🧬 Cell division!")
	if children_scene:
		var child = children_scene.instantiate()
		var heart_pump = get_parent()
		if heart_pump:
			heart_pump.add_child(child)
			child.global_position = global_position + Vector2(420, 0)
			child.player = self
		else:
			push_error("Cannot spawn child: Slime has no parent.")
	else:
		push_warning("No children_scene assigned!")


func _on_heart_pump_beat(value: float) -> void:
	pass # Replace with function body.
