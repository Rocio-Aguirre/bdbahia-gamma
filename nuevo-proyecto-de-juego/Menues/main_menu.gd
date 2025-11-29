extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menues/credits_menu.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://InfiniteRunner/game.tscn")
