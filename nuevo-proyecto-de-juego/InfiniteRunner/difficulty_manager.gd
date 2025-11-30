extends Node2D

@onready var count = 0
@export var upSpawnerCount = 10
func _on_difficulty_up_timer_timeout() -> void:
	GlobalDataRunner.speed=min(GlobalDataRunner.speed + GlobalDataRunner.accel, GlobalDataRunner.max_speed)
	$DifficultyUpTimer.start()
	count +=1 
	if count % upSpawnerCount == 0:
		print("UPLEVEL")
		GlobalDataRunner.obstacleSpawnAmount+=1
