extends Node2D

# Referencias a nodos
@onready var projectile = $Projectile
@onready var slingshot_position = $SlingshotPosition
@onready var line = $Line2D
@onready var trajectory_line = $TrajectoryLine

# Variables del juego
var dragging = false
var launch_power = 1350
var max_drag_distance = 150
var initial_projectile_position

func _ready():
	initial_projectile_position = projectile.global_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Verificar si el mouse está cerca del proyectil
				var distance = event.position.distance_to(projectile.global_position)
				if distance < 50 and not projectile.launched:
					dragging = true
			else:
				if dragging:
					launch_projectile()
					dragging = false

func _process(_delta):
	if dragging:
		# Calcular la posición de arrastre
		var mouse_pos = get_global_mouse_position()
		var drag_vector = slingshot_position.global_position - mouse_pos
		
		# Limitar la distancia de arrastre
		if drag_vector.length() > max_drag_distance:
			drag_vector = drag_vector.normalized() * max_drag_distance
		
		# Actualizar posición del proyectil
		projectile.global_position = slingshot_position.global_position - drag_vector
		
		# Dibujar la línea de la resortera
		update_slingshot_line()
		
		# Mostrar trayectoria predicha
		show_trajectory(drag_vector)
	else:
		line.clear_points()
		trajectory_line.clear_points()

func update_slingshot_line():
	line.clear_points()
	line.add_point(slingshot_position.position + Vector2(-30, 0))
	line.add_point(projectile.position)
	line.add_point(slingshot_position.position + Vector2(30, 0))

func show_trajectory(drag_vector):
	trajectory_line.clear_points()
	var velocity = drag_vector.normalized() * launch_power
	var pos = projectile.global_position
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	# Simular trayectoria
	for i in range(30):
		trajectory_line.add_point(pos - global_position)
		velocity.y += gravity * 0.02
		pos += velocity * 0.02

func launch_projectile():
	var drag_vector = slingshot_position.global_position - projectile.global_position
	var launch_velocity = drag_vector.normalized() * launch_power * (drag_vector.length() / max_drag_distance)
	
	projectile.launch(launch_velocity)
	
	# Esperar y resetear
	await get_tree().create_timer(3.0).timeout
	reset_projectile()

func reset_projectile():
	projectile.reset_position(initial_projectile_position)
