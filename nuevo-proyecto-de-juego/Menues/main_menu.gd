extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	SceneLoader.change_scene("res://Menues/credits_menu.tscn")

func _on_play_button_pressed() -> void:
	SceneLoader.change_scene("res://InfiniteRunner/game.tscn")
