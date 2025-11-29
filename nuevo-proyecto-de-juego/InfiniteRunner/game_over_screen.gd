extends Node2D


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://InfiniteRunner/game.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menues/main_menu.tscn")
