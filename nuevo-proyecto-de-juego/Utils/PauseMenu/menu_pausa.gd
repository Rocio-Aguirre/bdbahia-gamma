extends CanvasLayer

func _ready():
	visible = false



func _input(event):
	# Verificamos si se presionó ESC
	if event.is_action_pressed("ui_cancel"):
		# Importante: Marcamos el input como "manejado" para que nadie más lo use
		get_viewport().set_input_as_handled()
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused



func _on_texture_button_pressed() -> void:
	toggle_pause()
