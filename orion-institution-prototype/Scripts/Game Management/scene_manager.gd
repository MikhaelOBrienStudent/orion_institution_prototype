extends Node

@export var dialogue_runner_canvas: Node
@export var dialogue_runner: DialogueRunner
@export var navigation: Node
@export var location_manager: Node
@export var character_manager: Node


func EnableDialogue() -> void:
	dialogue_runner_canvas.visible = true
	navigation.visible = false
	dialogue_runner.RequestNextLine()

func EnableNavigation() -> void:
	dialogue_runner_canvas.visible = false
	navigation.visible = true
	
	#navigation.current_location.current_character = ""
	#navigation.ChangeLocation("HERE")


func SetCharacterLocation(character_name: String, character_location: String) -> void:
	#if navigation.current_location.current_character == character_name:
		#character_manager.ChangeCharacter("")
		
	location_manager.UpdateCharacterLocation(character_name, character_location)
	character_manager.ChangeCharacter(navigation.current_location.current_characters)

func ClearCharacterLocation(character_name:String) -> void:
	#if navigation.current_location.current_characters.has(character_name):
		#character_manager.ChangeCharacter("")
	location_manager.RemoveCharacterFromAllLocations(character_name)
	character_manager.ChangeCharacter(navigation.current_location.current_characters)
	
