extends Area2D
signal playerEntered

@onready var speed = GlobalDataRunner.speed

func _physics_process(delta: float) -> void:
	position.y += speed*delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("check_input"):
		await get_tree().create_timer(0.3).timeout
		playerEntered.emit()
