extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.call_deferred("switch")
		$flip.play()



func _on_flip_finished() -> void:
	queue_free()
