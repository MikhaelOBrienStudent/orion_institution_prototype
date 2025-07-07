extends Node

@export_category("Button SFX")

@export_group("Button Hover")
@export var button_hover_clip: AudioStream
@export var button_hover_volume: float = 1.0

@export_group("Button Press")
@export var button_press_clip: AudioStream
@export var button_press_volume: float = 1.0

@export_category("Dialogue")
@export_group("Continue")
@export var continue_clip: AudioStream
@export var continue_volume: float = 1.0

func _ready() -> void:
	get_tree().node_added.connect(_on_node_entered_tree)

func _on_node_entered_tree(node: Node) -> void:
	if node is Button:
		node.mouse_entered.connect(button_hover_sound)
		node.pressed.connect(button_press_sound)
	if node is ContinueButton:
		node.pressed.connect(continue_dialogue_sound)

func button_hover_sound() -> void:
	SfxPlayer.PlaySound(button_hover_clip, button_hover_volume, SfxPlayer.sfx_type.UI)

func button_press_sound() -> void:
	SfxPlayer.PlaySound(button_press_clip, button_press_volume, SfxPlayer.sfx_type.UI)

func continue_dialogue_sound() -> void:
	SfxPlayer.PlaySound(continue_clip, continue_volume, SfxPlayer.sfx_type.WORLD)
