extends Node2D

var how:PackedScene = preload("res://scene/how/how.tscn")
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Globals.load_highscore()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")


func _on_how_pressed() -> void:
	get_tree().change_scene_to_packed(how)
