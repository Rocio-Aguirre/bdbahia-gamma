extends Node

# Stats jugador
@export var vidas = 3
@export var initial_speed = 200
@export var max_speed = 1000
@export var accel = 50
@onready var speed = initial_speed


func reset_data():
	vidas = 3
	initial_speed = 100
	max_speed = 1500
