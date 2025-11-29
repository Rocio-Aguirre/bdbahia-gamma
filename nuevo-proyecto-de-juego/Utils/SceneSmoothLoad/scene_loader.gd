extends CanvasLayer

@export var duration: float = 1.0

func change_scene(new_scene: String):
	$ColorRect.mouse_filter = $ColorRect.MOUSE_FILTER_STOP
	var anim = create_tween()
	anim.tween_property($ColorRect,"modulate:a",1.0,duration)
	await anim.finished
	
	get_tree().change_scene_to_file(new_scene)
	
	anim = create_tween()
	anim.tween_property($ColorRect,"modulate:a",0.0,duration)
	await anim.finished
	$ColorRect.mouse_filter = $ColorRect.MOUSE_FILTER_IGNORE
