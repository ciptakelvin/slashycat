extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://scene/menu.tscn")
