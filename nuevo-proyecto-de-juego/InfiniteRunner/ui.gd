extends CanvasLayer

@export var min_angle_deg = -90.0
@export var max_angle_deg = 90.0


func _process(delta: float) -> void:
	update_ui(delta)
	
func update_lives():
	# Calculo Vidas
	if GlobalDataRunner.vidas == 2:
		$ColorRect/HeartContainer.get_child(2).queue_free()
	elif GlobalDataRunner.vidas == 1:
		$ColorRect/HeartContainer.get_child(1).queue_free()

func update_ui(delta):
	# Calculo velocidad
	var rotacion_obj = remap(GlobalDataRunner.speed,GlobalDataRunner.initial_speed,GlobalDataRunner.max_speed,min_angle_deg,max_angle_deg)
	rotacion_obj = clamp(rotacion_obj, min_angle_deg, max_angle_deg)
	$ColorRect/SpeedMeter/Indicator.rotation_degrees = lerp($ColorRect/SpeedMeter/Indicator.rotation_degrees, rotacion_obj,  delta*5.0)
	# Calculo Progreso
	var porcentajeProgreso = -($"../VictoryTimer".time_left-$"../VictoryTimer".wait_time)
	
	print(porcentajeProgreso)
	$ColorRect/TimerBar.value = porcentajeProgreso
