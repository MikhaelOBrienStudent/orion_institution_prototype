extends Node
signal StartDialogue
signal EnableNavigation

signal SetCharacterLocation(char_name: String, char_loc: String)
signal RemoveCharacter(char_name: String)

signal ChangeLocation(location_name: String)

@onready var dialogue_signals: Node = $"../DialogueSignals"

@export var dialogue_nodes: Array[Node]

@export var player_input_ui: Control



func GetPlayerName() -> void:
	print("Getting player name...")
	player_input_ui.visible = true

func HideInput() -> void:
	player_input_ui.visible = false


func _on_dialogue_runner_on_unhandled_command(commandText: String) -> void:
	print(commandText + " command not found")


func _on_player_text_input_input_received() -> void:
	dialogue_signals.ChangePlayerName(player_input_ui.input_value)


func _on_dialogue_signals_enable_navigation_signal() -> void:
	EnableNavigation.emit()


func _on_dialogue_signals_start_dialogue_signal() -> void:
	StartDialogue.emit()


func _on_dialogue_signals_play_sound_signal(sfx_name: String, sfx_volume: float) -> void:
	SfxPlayer.PlaySound(null, sfx_volume, SfxPlayer.sfx_type.WORLD, sfx_name)


func _on_dialogue_signals_set_character_location_signal(character_name: String, character_location: String) -> void:
	SetCharacterLocation.emit(character_name, character_location)


func _on_dialogue_signals_remove_character_signal(character_name: String) -> void:
	RemoveCharacter.emit(character_name)


func _on_dialogue_signals_change_player_location_signal(location_name: String) -> void:
	ChangeLocation.emit(location_name)
