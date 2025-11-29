extends RigidBody2D

var launched = false
var confetti_scene = preload("res://Gomera/confetti.tscn")

func _ready():
	# Configurar el modo del cuerpo
	freeze = true
	contact_monitor = true
	max_contacts_reported = 4

func launch(velocity: Vector2):
	launched = true
	freeze = false
	linear_velocity = velocity
	
	# Añadir rotación basada en la velocidad
	angular_velocity = velocity.x / 100

func reset_position(pos: Vector2):
	launched = false
	freeze = true
	global_position = pos
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	rotation = 0

func _integrate_forces(state):
	# Limitar la velocidad máxima
	if state.linear_velocity.length() > 1000:
		state.linear_velocity = state.linear_velocity.normalized() * 1000
	
func _on_body_entered(_body):
	# Crear serpentinas cuando toca cualquier cosa
	if launched:
		spawn_confetti()

func spawn_confetti():
	var confetti = confetti_scene.instantiate()
	get_parent().add_child(confetti)
	confetti.global_position = global_position
