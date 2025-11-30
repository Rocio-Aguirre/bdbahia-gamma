extends RigidBody2D
var launched = false
var confetti_scene = preload("res://Gomera/confetti.tscn")
var start_x 

@onready var sprite = $Sprite2D
var original_scale = Vector2.ZERO

func _ready():
	freeze = true
	start_x = global_position.x
	contact_monitor = true
	max_contacts_reported = 4
	original_scale = sprite.scale
	body_entered.connect(_on_body_entered)


func _process(_delta):
	if launched:
		var total_distance = 900.0 - 126.0
		var distance_traveled = global_position.x - start_x
		var progress = clamp(distance_traveled / total_distance, 0.0, 1.0)
		var new_scale = lerp(0.75, 0.14, progress)
		sprite.scale = Vector2(new_scale, new_scale)

func launch(velocity: Vector2):
	$DisparoGomera.play()  
	launched = true
	freeze = false
	linear_velocity = velocity
	angular_velocity = velocity.x / 100

func reset_position(pos: Vector2):
	launched = false
	freeze = true
	global_position = pos
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	rotation = 0
	sprite.scale = original_scale

func _integrate_forces(state):
	if state.linear_velocity.length() > 1000:
		state.linear_velocity = state.linear_velocity.normalized() * 1000

func _on_body_entered(body):
	if launched:
		# DEBUG - Ver qué tocó
		print("Tocó algo: ", body.name)
		
		spawn_confetti()
		await get_tree().create_timer(0.5).timeout
		
		# Verificar qué suelo tocó
		if body.name == "GroundVictory":
			print("Es victoria!")
			get_parent().show_victory()
		elif body.name == "GroundDefeat":
			print("Es derrota!")
			get_parent().show_defeat()
		else:
			print("No es ni victoria ni derrota")

func spawn_confetti():
	var confetti = confetti_scene.instantiate()
	get_parent().add_child(confetti)
	confetti.global_position = global_position
