extends Area2D

var is_die:=false
func add_point():
	if not is_die:
		is_die=true
		$GPUParticles2D.emitting=true
		$Sprite2D.hide()
		$coin.play()


func _on_gpu_particles_2d_finished() -> void:
	queue_free()
