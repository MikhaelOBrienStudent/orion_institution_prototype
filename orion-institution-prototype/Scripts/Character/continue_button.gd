extends Button
class_name ContinueButton

@export var character_manager: Node

func _on_pressed() -> void:
	pass
	#if character_manager.current_character != null:
		#character_manager.current_character.Talk()
