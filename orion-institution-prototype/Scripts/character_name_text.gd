extends RichTextLabel



func _on_finished() -> void:
	if text == "":
		get_parent().visible = false
	else:
		get_parent().visible = true
