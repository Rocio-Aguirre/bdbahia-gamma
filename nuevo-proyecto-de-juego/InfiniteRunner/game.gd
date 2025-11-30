extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var background_music = $BackgroundMusic  # AGREGADO - Música de fondo
@export var victoryZoneScene: PackedScene

func _ready() -> void:
	$Player.playerDamage.connect(checkFailState)
	$AnimatedSprite2D.play()
	background_music.play()  # AGREGADO - Reproducir música al iniciar
	
func winState():
	background_music.stop()  
	get_tree().change_scene_to_file("res://Gomera/main.tscn")

func checkFailState():
	$ScreenshakeSystem.add_trauma(1.0)
	$UI.update_lives()
	if GlobalDataRunner.vidas <= 0:
		background_music.stop()  
		get_tree().call_deferred("change_scene_to_file","res://InfiniteRunner/game_over_screen.tscn")

func _on_victory_timer_timeout() -> void:
	var victoryZoneInstance = victoryZoneScene.instantiate()
	victoryZoneInstance.global_position = global_position
	victoryZoneInstance.global_position.y -=700
	victoryZoneInstance.playerEntered.connect(winState)
	$Background.add_sibling(victoryZoneInstance)
