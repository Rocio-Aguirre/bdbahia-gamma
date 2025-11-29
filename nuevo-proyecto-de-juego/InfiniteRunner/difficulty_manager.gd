extends Node2D



func _on_difficulty_up_timer_timeout() -> void:
	GlobalDataRunner.speed=min(GlobalDataRunner.speed + GlobalDataRunner.accel, GlobalDataRunner.max_speed)
	$DifficultyUpTimer.start()
