extends CanvasLayer

@export var play_button: Button
@export var resume_button: Button
@export var new_game_button: Button

func _ready() -> void:
	update_buttons()

func update_buttons() -> void:
	if SaveManagement.has_save_file:
		play_button.hide()
		resume_button.show()
		new_game_button.show()
	else:
		play_button.show()
		resume_button.hide()
		new_game_button.hide()
