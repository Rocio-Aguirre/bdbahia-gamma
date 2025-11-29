extends Node2D
signal endWarning


func _ready() -> void:
	$AnimationPlayer.play("warningAnim")
	await $AnimationPlayer.animation_finished
	endWarning.emit()
	queue_free()
