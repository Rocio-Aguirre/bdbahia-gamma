extends Node2D

@onready var player: CharacterBody2D = $Player
@export var victoryZoneScene: PackedScene




func _ready() -> void:
	$Player.playerDamage.connect(checkFailState)
	

func winState():
	get_tree().change_scene_to_file("res://win_state_screen.tscn")


func checkFailState():
	$UI.update_lives()
	if GlobalDataRunner.vidas <= 0:
		get_tree().call_deferred("change_scene_to_file","res://game_over_screen.tscn")



func _on_victory_timer_timeout() -> void:
	var victoryZoneInstance = victoryZoneScene.instantiate()
	victoryZoneInstance.global_position = $SpawnManager.global_position
	victoryZoneInstance.playerEntered.connect(winState)
	add_child(victoryZoneInstance)
