extends Node

@export var dialogue_runner: Node
@export var navigation: Node

func EnableDialogue() -> void:
	dialogue_runner.visible = true
	navigation.visible = false

func EnableNavigation() -> void:
	dialogue_runner.visible = false
	navigation.visible = true
	navigation.current_location.current_character = ""
	navigation.ChangeLocation("HERE")
