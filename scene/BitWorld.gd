extends StaticBody2D

@onready var player: CharacterBody2D = $"../player"

func _physics_process(delta: float) -> void:
	position.x = player.position.x
