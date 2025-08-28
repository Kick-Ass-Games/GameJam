extends Node2D

@export var cantidad_enemigos: int = 1000
@export var enemy_scene: PackedScene

var jugador
var spawn_zones = []

func _ready():
	if has_node("Slime"):
		jugador = $Slime
	else:
		push_error("No se encontró el nodo Slime")
		return

	# Restaurar solo la Y, pero reiniciar la X
	if Global.jugador_pos_guardada.y != 0.0:
		jugador.position = Vector2(0, Global.jugador_pos_guardada.y)
		Global.jugador_pos_guardada.y = 0.0
	else:
		Global.jugador_pos_guardada.y = jugador.position.y

	spawn_zones = get_tree().get_nodes_in_group("zonas_spawn")

	var posicion_inicio = Vector2(0, jugador.position.y)
	generar_objetos_procedurales(posicion_inicio)

func generar_objetos_procedurales(posicion_base: Vector2):
	if spawn_zones.is_empty():
		push_error("No hay zonas de spawn.")
		return

	for i in range(cantidad_enemigos):
		var enemigo = enemy_scene.instantiate()
		var zona = spawn_zones[randi() % spawn_zones.size()]
		
		if not zona.has_method("get_random_position"):
			push_error("Zona de spawn no tiene método 'get_random_position'")
			continue

		var spawn_pos = zona.get_random_position() + posicion_base
		enemigo.position = spawn_pos
		add_child(enemigo)


func eliminar_enemigos():
	for child in get_children():
		if child.is_in_group("enemigo"):
			child.queue_free()


func _on_zona_final_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		print("🔁 ZonaFinal detectó al jugador")

		# Guardar solo la Y
		Global.jugador_pos_guardada.y = body.position.y

		# Eliminar enemigos y regenerar
		eliminar_enemigos()

		# Mover al jugador a x = 0 pero mantener y
		body.position = Vector2(0, body.position.y)

		# Regenerar enemigos desde esa nueva posición
		generar_objetos_procedurales(Vector2(0, body.position.y))

func reiniciar_nivel():
	var jugador = get_tree().get_nodes_in_group("jugador")[0]
	var pos_y = jugador.position.y

	# Reposicionar al jugador en X = 0
	jugador.position = Vector2(0, pos_y)

	# Eliminar enemigos
	for enemigo in get_tree().get_nodes_in_group("enemigos"):
		enemigo.queue_free()

	# Generar enemigos desde la nueva posición base
	generar_objetos_procedurales(jugador.position)

	print("♻️ Nivel reiniciado sin cambiar altura del jugador")
