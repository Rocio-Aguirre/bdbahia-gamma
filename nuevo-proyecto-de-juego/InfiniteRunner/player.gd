extends CharacterBody2D
signal playerDamage


@export var horizontal_move = 20.0

func check_input():
	var array = Input.get_axis("ui_left","ui_right")
	return array

func apply_damage():
	GlobalDataRunner.vidas -= 1
	playerDamage.emit()
	

func _physics_process(delta: float) -> void:
	var direction = check_input()
	velocity = Vector2.RIGHT*horizontal_move*direction
	move_and_slide()
