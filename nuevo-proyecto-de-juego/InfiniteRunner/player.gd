extends CharacterBody2D
signal playerDamage


@export var horizontal_move = 20.0

func check_input():
	var array = Input.get_axis("ui_left","ui_right")
	return array

func apply_damage():
	GlobalDataRunner.vidas -= 1
	playerDamage.emit()
	GlobalDataRunner.speed = max(GlobalDataRunner.initial_speed, GlobalDataRunner.speed/2)
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("playerHit")
	await $AnimationPlayer.animation_finished
	$CollisionShape2D.set_deferred("disabled",false)
	
	

func _physics_process(delta: float) -> void:
	var direction = check_input()
	velocity = Vector2.RIGHT*horizontal_move*direction
	move_and_slide()
