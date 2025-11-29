extends CanvasLayer

func _process(delta: float) -> void:
	update_ui()
	
func update_ui():
	$ColorRect/SpeedLabel.text = str(GlobalDataRunner.speed)
	$ColorRect/VidasLabel.text = str(GlobalDataRunner.vidas)
