extends Node

@export var character_nodes: Array[Character]

var current_character: Character

func ChangeCharacter(character_name: String) -> void:
	current_character = null
	for character in character_nodes:
		if character_name == character.character_name:
			character.visible = true
			current_character = character
		else:
			character.visible = false

func CharacterLeaves(character_name: String) -> void:
	if current_character.character_name == character_name:
		current_character.visible = false
		current_character = null
