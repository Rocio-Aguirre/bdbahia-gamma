extends Node2D

@export var camara: Camera2D
@export var noise: FastNoiseLite

# Parametros
@export var decay = 2.0
@export var max_offset: Vector2 = Vector2(50,40)
@export var max_roll = 1.0

# vars
var trauma = 0.0
var noise_y = 0

func _ready() -> void:
	if not noise:
		noise = FastNoiseLite.new()
		noise.noise_type = FastNoiseLite.TYPE_PERLIN
		noise.frequency = 0.2

func add_trauma(amount: float):
	trauma = min(trauma+amount,1.0)

func _process(delta: float) -> void:
	if trauma > 0:
		trauma = max(trauma-decay*delta,0)
		_shake()
	elif camara.offset != Vector2.ZERO:
		camara.offset = Vector2.ZERO
		camara.rotation = 0

func _shake():
	var amount = pow(trauma,2)
	noise_y+=1
	var rotation_offset = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	var x_offset = max_offset.x * amount * noise.get_noise_2d(noise.seed + 1, noise_y)
	var y_offset = max_offset.y * amount * noise.get_noise_2d(noise.seed + 2, noise_y)
	camara.offset = Vector2(x_offset, y_offset)
	camara.rotation = rotation_offset
