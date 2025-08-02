extends Node

@export var character_nodes: Array[Character]

var current_character: Character

var talking_character_name: String = ""

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

func UpdateCharacterSprite(sprite_type: String, sprite_name: String) -> void: 
	if sprite_type == "pose":
		current_character.UpdatePose(sprite_name)
	if sprite_type == "expression":
		current_character.UpdateFace(sprite_name)


func _on_signal_receiver_talking_character_name(character_name: String) -> void:
	talking_character_name = character_name
	if current_character && talking_character_name == current_character.character_name:
		current_character.Talk()
