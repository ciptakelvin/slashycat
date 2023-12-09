extends Node2D


func _ready() -> void:
	var r_val = randf()
	if r_val>0.5:
		scale.y = -scale.y

func _process(delta: float) -> void:
	if Globals.is_die:
		return
	if Input.is_action_just_pressed("jump"):
		change()

func change():
	scale.y = -scale.y


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.die()


func _on_die_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.die()


