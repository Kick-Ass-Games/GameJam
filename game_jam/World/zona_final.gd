extends Area2D

func _on_ZonaFinal_body_entered(body):
	if body.is_in_group("jugador"):
		print("🔁 El jugador alcanzó la ZonaFinal.")
		get_tree().current_scene.reiniciar_nivel()
