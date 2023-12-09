extends Label

func add_score(value:int) -> void:
	Globals.score += value
	text = str(round(Globals.score))
