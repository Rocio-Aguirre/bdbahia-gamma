extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	$UI.update_ui()

func checkEndGame():
	if GlobalDataRunner.vidas <= 0:
		get_tree().change_scene_to_file("res://game_over_screen.tscn")
