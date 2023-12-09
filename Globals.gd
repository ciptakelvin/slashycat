extends Node

signal flip

var is_jumping = false
var high_score:float = 0
var score:float = 0
var is_die = false

func on_die():
	if score>high_score:
		high_score=score
		save_highscore()

func reset():
	score = 0
	is_die = false

func save_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_float(high_score)

func load_highscore():
	if not FileAccess.file_exists("user://highscore.save"):
		print("File not exist")
		return

	var file = FileAccess.open("user://highscore.save", FileAccess.READ)
	high_score = file.get_float()
	
