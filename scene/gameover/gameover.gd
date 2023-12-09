extends Control

func on_die():
	$ColorRect/highscore.text = str(round(Globals.high_score))
	$ColorRect/score.text = str(round(Globals.score))

func _on_play_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Globals.reset()
	get_tree().change_scene_to_file("res://scene/game.tscn")
