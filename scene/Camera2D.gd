extends Camera2D

@export var player:CharacterBody2D
@export var arm_offset:Vector2

func _physics_process(delta: float) -> void:
	position = player.position + arm_offset

func boom():
	$AnimationPlayer.play("zoom")
