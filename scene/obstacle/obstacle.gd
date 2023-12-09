extends Area2D

func _ready() -> void:
	Globals.flip.connect(change)
	var r_val = randf()
	if r_val>0.5:
		scale.y = -scale.y


func change():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(scale.x,-scale.y),0.2)



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
