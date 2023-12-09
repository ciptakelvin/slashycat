extends Node

@onready var player: Player = $"../player"
@export var basic_obstacle:PackedScene

func _on_timer_timeout() -> void:
	instance_pattern()

func instance_pattern():
	var node = basic_obstacle.instantiate()
	node.position.x = player.position.x + get_viewport().size.x * 2
	add_child(node)
