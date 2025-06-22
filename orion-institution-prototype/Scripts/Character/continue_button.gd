extends Button

@export var talking_character: Character

func _on_pressed() -> void:
	talking_character.Talk()
