extends Node

@onready var player: Player = $"../player"
@export var score_rect:PackedScene
@export var basic_obstacle:PackedScene
@export var flipper:PackedScene

func _ready() -> void:
	$Timer.start(3)

func spawn():
	if randf()<0.05:
		bonus()
	else:
		Callable(self,"pattern"+str(randi_range(1,4))).call()

func add_flipper(packed:PackedScene):
	var node = packed.instantiate()
	if node is Node2D:
		if randf()>0.5:
			node.position.y = -30
			node.modulate = Color.WHITE
		else:
			node.position.y = 30
			node.modulate = Color.BLACK
		node.position.x = player.position.x + get_viewport().size.x * 2
		add_child(node)


func add_node(packed:PackedScene):
	var node = packed.instantiate()
	if node is Node2D:
		node.position.y = 0
		node.position.x = player.position.x + get_viewport().size.x * 2
		add_child(node)

func _on_timer_timeout() -> void:
	spawn()
	$Timer.start(1)

#Pattern
func pattern1():
	add_node(score_rect)
	await get_tree().create_timer(0.8 + randf_range(-0.4,0.1)).timeout
	add_node(basic_obstacle)

func pattern2():
	add_node(basic_obstacle)
	await get_tree().create_timer(0.1 + randf_range(0.1,0.3)).timeout
	add_flipper(flipper)

func bonus():
	add_node(score_rect)
	await get_tree().create_timer(0.15).timeout
	add_node(score_rect)
	await get_tree().create_timer(0.15).timeout
	add_node(score_rect)
	await get_tree().create_timer(0.15).timeout

func pattern3():
	add_node(score_rect)
	await get_tree().create_timer(0.4).timeout
	add_flipper(flipper)
	await get_tree().create_timer(0.4).timeout

func pattern4():
	add_node(score_rect)
	await get_tree().create_timer(0.3).timeout
	add_node(basic_obstacle)
	await get_tree().create_timer(0.3).timeout
	add_flipper(flipper)
	await get_tree().create_timer(0.3).timeout
