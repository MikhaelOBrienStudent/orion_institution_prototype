extends Node

@export var dialogue_runner: Node
@export var navigation: Node
@export var location_manager: Node
@export var character_manager: Node


func EnableDialogue() -> void:
	dialogue_runner.visible = true
	navigation.visible = false

func EnableNavigation() -> void:
	dialogue_runner.visible = false
	navigation.visible = true
	
	#navigation.current_location.current_character = ""
	#navigation.ChangeLocation("HERE")

func SetCharacterLocation(character_name: String, character_location: String) -> void:
	if navigation.current_location.current_character == character_name:
		character_manager.ChangeCharacter("")
	location_manager.UpdateCharacterLocation(character_name, character_location)
	if character_location == navigation.current_location.location_name:
		character_manager.ChangeCharacter(character_name)

func ClearCharacterLocation(character_name:String) -> void:
	if navigation.current_location.current_character == character_name:
		character_manager.ChangeCharacter("")
	location_manager.RemoveCharacterFromAllLocations(character_name)
