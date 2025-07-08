extends Control
signal InputReceived

@export var line_edit: LineEdit
@export var label: Label

var input_value

func _on_line_edit_text_submitted(new_text: String) -> void:
	input_value = new_text
	InputReceived.emit()


func _on_line_edit_text_changed(new_text: String) -> void:
	input_value = new_text
	InputReceived.emit()
