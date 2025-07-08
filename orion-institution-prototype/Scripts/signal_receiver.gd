extends Node
signal StartDialogue
signal EnableNavigation

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
