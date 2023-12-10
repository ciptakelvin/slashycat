extends Node2D

class_name Game

#TODO DONE - Flipper masukin ke pattern spawner 
#TODO DONE - Player art
#TODO SKIP DULU - Laser Obstacle
#TODO Garap Musik, SFX
#TODO Combo score
#TODO Garap dan Percantik GUI, Menu, Credit
#TODO Design art itch io

@onready var blacks = get_tree().get_nodes_in_group("black")
@onready var whites = get_tree().get_nodes_in_group("white")

func _ready() -> void:
	$CanvasLayer/gameover/AnimationPlayer.play("RESET")
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func white():
	for b in blacks:
		if b is CollisionShape2D:
			b.disabled = true
	
	for w in whites:
		if w is CollisionShape2D:
			w.disabled = false


func black():
	for b in blacks:
		if b is CollisionShape2D:
			b.disabled = false
	
	for w in whites:
		if w is CollisionShape2D:
			w.disabled = true

func die():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Globals.on_die()
	$CanvasLayer/gameover.on_die()
	$CanvasLayer/Score.set_process(false)
	$CanvasLayer/gameover/AnimationPlayer.play("RESET")
	$CanvasLayer/gameover/AnimationPlayer.play("slide_in")

func _input(event: InputEvent) -> void:
	if not Globals.is_die:
		if event.is_action_pressed("esc"):
			get_tree().change_scene_to_file("res://scene/menu.tscn")


