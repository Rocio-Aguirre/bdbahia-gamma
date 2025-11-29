extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@export var obstacleScenesArray: Array[PackedScene]
@export var warningScene: PackedScene
@export var spawn_time_rate = 3.0
@export var min_spawn_rate = 1.2




func _on_spawn_timer_timeout() -> void:
	print("test")
	var instancia_obstaculo = obstacleScenesArray.pick_random().instantiate()
	# Conseguir pos random de pathfollow
	# Choose a random location on Path2D.
	var mob_spawn_location = $Path2D/PathFollow2D
	mob_spawn_location.progress_ratio = randf()
	
	# Create Warning
	var instancia_warning = warningScene.instantiate()
	instancia_warning.global_position = mob_spawn_location.global_position
	instancia_warning.global_position.y+=50
	get_parent().add_child(instancia_warning)
	await instancia_warning.endWarning
	
	# Set the mob's position to the random location.
	instancia_obstaculo.global_position = mob_spawn_location.global_position
	get_parent().add_child(instancia_obstaculo)
	spawn_time_rate = max(min_spawn_rate,spawn_time_rate-0.5)
	spawn_timer.wait_time = spawn_time_rate
	spawn_timer.start()
