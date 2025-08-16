extends Node

@onready var main: Node = get_node("/root/Main")

@export var character_nodes: Array[Character]

var current_characters: Array[Character]

var talking_character: Character = null

var character_pose: String
var character_expression: String

##The function used to set the characters in the current location to visible, and to hide all others
func ChangeCharacter(character_names: Array[String]) -> void:
	current_characters.clear()
	for character in character_nodes:
		if character_names.has(character.character_name):
			character.Arrive()
			#character.position.x = 0
			current_characters.append(character)
		else:
			if character.visible:
				character.Leave()
	UpdateCharacterSpacing()

func CharacterLeaves(character_name: String) -> void:
	var character_to_remove: Character
	for character in current_characters:
		if character.character_name == character_name:
			character.Leave()
			character_to_remove = character
	var char_index = current_characters.find(character_to_remove)
	current_characters.remove_at(char_index)
	UpdateCharacterSpacing()

func UpdateCharacterSprite(sprite_type: String, sprite_name: String) -> void: 
	if sprite_type == "pose":
		talking_character.UpdatePose(sprite_name)
	if sprite_type == "expression":
		talking_character.UpdateFace(sprite_name)


func _on_signal_receiver_talking_character_name(character_name: String) -> void:
	for character in current_characters:
		if character.character_name == character_name:
			talking_character = character
			talking_character.Talk()
			talking_character.Highlight()
		else:
			if character_name != "" && character_name != main.PlayerName:
				character.Highlight(false)

func UpdateCharacterSpacing() -> void:
	if current_characters.is_empty():
		return
	
	var starting_value = 0
	var spacing_value = 1920.0/(current_characters.size()+1)
	
	for i in current_characters.size():
		var new_position = starting_value + (spacing_value * (i+1))
		var move_tween = create_tween()
		move_tween.tween_property(current_characters[i], "position:x", new_position, 0.25).set_ease(Tween.EASE_IN_OUT)
