extends CanvasLayer
signal StartDialogue

@export var current_location: Location

@export var left_button: Button
@export var left_label: Label

@export var right_button: Button
@export var right_label: Label

@export var top_button: Button
@export var top_label: Label

@export var bottom_button: Button
@export var bottom_label: Label

@export var character_manager: Node

func _ready() -> void:
	current_location.Arrive()
	
	var direction_check = func(loc: Location) -> bool:
		if loc:
			return true
		return false
	
	left_button.visible = direction_check.call(current_location.left_location)
	if current_location.left_location:
		left_label.text = current_location.left_location.location_name
	
	right_button.visible = direction_check.call(current_location.right_location)
	if current_location.right_location:
		right_label.text = current_location.right_location.location_name
	
	top_button.visible = direction_check.call(current_location.top_location)
	if current_location.top_location:
		top_label.text = current_location.top_location.location_name
	
	bottom_button.visible = direction_check.call(current_location.bottom_location)
	if current_location.bottom_location:
		bottom_label.text = current_location.bottom_location.location_name
	
	character_manager.ChangeCharacter(current_location.current_character)

func ChangeLocation(direction: String) -> Location:
	var new_location: Location
	match direction:
		"LEFT":
			new_location = current_location.left_location
		"RIGHT":
			new_location = current_location.right_location
		"TOP":
			new_location = current_location.top_location
		"BOTTOM":
			new_location = current_location.bottom_location
		"HERE":
			new_location = current_location
	
	var direction_check = func(loc: Location) -> bool:
		if loc:
			return true
		return false
	
	left_button.visible = direction_check.call(new_location.left_location)
	if new_location.left_location:
		left_label.text = new_location.left_location.location_name
	
	right_button.visible = direction_check.call(new_location.right_location)
	if new_location.right_location:
		right_label.text = new_location.right_location.location_name
	
	top_button.visible = direction_check.call(new_location.top_location)
	if new_location.top_location:
		top_label.text = new_location.top_location.location_name
	
	bottom_button.visible = direction_check.call(new_location.bottom_location)
	if new_location.bottom_location:
		bottom_label.text = new_location.bottom_location.location_name
	
	current_location.Leave()
	new_location.Arrive()
	character_manager.ChangeCharacter(new_location.current_character)
	if new_location.current_character:
		StartDialogue.emit()
	return new_location

func _on_left_pressed() -> void:
	current_location = ChangeLocation("LEFT")

func _on_right_pressed() -> void:
	current_location = ChangeLocation("RIGHT")

func _on_top_pressed() -> void:
	current_location = ChangeLocation("TOP")

func _on_bottom_pressed() -> void:
	current_location = ChangeLocation("BOTTOM")
