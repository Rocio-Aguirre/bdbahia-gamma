extends Node2D


var speed
func _ready() -> void:
	speed = GlobalDataRunner.speed
	$SpriteCollection.get_children().pick_random().visible = true


func _physics_process(delta: float) -> void:
	position.y += speed*delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
