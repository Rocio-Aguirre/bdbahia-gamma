extends CharacterBody2D
signal playerDamage
@export var horizontal_move = 20.0
@export var rotation_max = 30.0
@export var rotation_rate= 5.0

@onready var controlled = true

func trigger_impact_sparks():
	# 1. Encendemos el "chorro" de chispas
	$ChispasPoint/ChispasParticles	.emitting = true
	$ChispasPoint/ChispasParticles2.emitting = true

	# 2. Esperamos los segundos que quieras (ej. 2.0 segundos de raspado)
	# Usamos un timer temporal que no bloquea el resto del juego
	await get_tree().create_timer(2.0).timeout

	# 3. Cortamos el chorro
	$ChispasPoint/ChispasParticles.emitting = false
	$ChispasPoint/ChispasParticles2.emitting = false


func check_input():
	var dir := Input.get_axis("ui_left","ui_right")
	return dir

func apply_damage():
	GlobalDataRunner.vidas -= 1
	playerDamage.emit()
	GlobalDataRunner.speed = max(GlobalDataRunner.initial_speed, GlobalDataRunner.speed/2)
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("playerHit")
	await $AnimationPlayer.animation_finished
	$CollisionShape2D.set_deferred("disabled",false)

func applyDebuff():
	trigger_impact_sparks()
	$UncontrolledTimer.start()
	controlled = false
	

func _physics_process(delta: float) -> void:
	if controlled:
		var direction = check_input()
		var target_rotation = rotation_max * direction
		rotation_degrees = lerp(rotation_degrees, target_rotation, rotation_rate * delta)
		velocity = Vector2.RIGHT*horizontal_move*direction
		$EscapePoint/HumoParticles.emitting = true
	else: 
		velocity = Vector2.RIGHT*horizontal_move*randf_range(-1.0,1.0)
		rotation_degrees = lerp(rotation_degrees, 0.0, rotation_rate * delta)
		$EscapePoint/HumoParticles.emitting = false

	
	move_and_slide()


func _on_uncontrolled_timer_timeout() -> void:
	controlled = true
