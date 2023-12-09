extends CharacterBody2D

class_name Player
@onready var intro: AnimationPlayer = $"../CanvasLayer/Intro/AnimationPlayer"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var intro_slash: AudioStreamPlayer = $"../CanvasLayer/Intro/slash"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var game:Game
var is_white = true
var in_hitbox = false
var speed:float = 1200.0
var elapsed:float = 0.0
const JUMP_VELOCITY = -1600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:

	elapsed += delta
	if Globals.is_die:
		return
	speed += delta * 4
	velocity.x = speed
	velocity.x = clamp(velocity.x, 0, 1400)
	# Add the gravity.():
	if is_white:
		if not is_on_floor():
			velocity.y += gravity * delta * 6
	else:
		if not is_on_ceiling():
			velocity.y -= gravity * delta * 6

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_white and is_on_floor():
			if not intro_slash.playing:
				$jump.play()
			$AnimatedSprite2D/AnimationPlayer.stop()
			$AnimatedSprite2D/AnimationPlayer.play("jump")
			Globals.flip.emit()
			velocity.y = JUMP_VELOCITY
		elif not is_white and is_on_ceiling():
			if not intro_slash.playing:
				$jump.play()
			$AnimatedSprite2D/AnimationPlayer.stop()
			$AnimatedSprite2D/AnimationPlayer.play("jump")
			Globals.flip.emit()
			velocity.y = -JUMP_VELOCITY
	
	if Input.is_action_just_pressed("switch"):
		switch()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not $AnimatedSprite2D/AnimationPlayer.is_playing():
		$AnimatedSprite2D/AnimationPlayer.play("idle")
	move_and_slide()

func switch():
	
	slash()
	if not intro_slash.playing:
		$flip.play()
	velocity.y = 0
	position.y = -position.y
	if is_white:
		$AnimationPlayer.play("to_black")
		$GPUParticles2D.self_modulate = Color("2b2b2b")
		animated_sprite_2d.play("black")
		game.black()
	else:
		$AnimationPlayer.play("to_white")
		$GPUParticles2D.self_modulate = Color.WHITE
		animated_sprite_2d.play("white")
		game.white()
	
	animated_sprite_2d.flip_v = not animated_sprite_2d.flip_v
	is_white = not is_white

func slash():
	if is_on_floor() and is_white:
		return
	
	if is_on_ceiling() and not is_white:
		return
	
	if not intro_slash.playing:
		$slash.play()
	$Slash.play("slash")
	$Hitbox/CollisionShape2D.disabled = false
	camera_2d.boom()
	await get_tree().create_timer(0.02).timeout
	$Hitbox/CollisionShape2D.disabled = true


func die():
	if not Globals.is_die:
		$die.play()
		intro.play("blink")
		Globals.is_die = true
		$GPUParticles2D.emitting = true
		animated_sprite_2d.queue_free()
		
		var timer = get_tree().create_timer(1).timeout
		await timer
		game.die()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("point") and abs(area.position.y) < abs(position.y):
		area.add_point()
		get_tree().get_first_node_in_group("score").add_score(1)
