extends Node2D

@onready var defeat_sound = $AudioStreamPlayer

func _ready():
	# Reproducir sonido cuando aparece la pantalla de Game Over
	defeat_sound.play()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://InfiniteRunner/game.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menues/main_menu.tscn")
