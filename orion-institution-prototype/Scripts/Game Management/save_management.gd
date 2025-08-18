extends Node
class_name SaveManager

signal SaveGame
signal LoadGame()

var save_data: Dictionary

var saved_variables: Dictionary
var saved_node_name: String

var save_path: String = "user://savegame.save"

var has_save_file: bool = false

func _ready() -> void:
	has_save_file = get_save_file()

func add_save_data(key:String, data:Dictionary) -> void:
	save_data[key] = data

func save_game() -> void:
	print("Saving Game...")
	SaveGame.emit()#Informs connected nodes to update the information

	save_data["saved_variables"] = saved_variables
	save_data["saved_node_name"] = saved_node_name
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file == null:
		print("Error: Save location not found {0}".format([save_path]))
		return
	var jstr = JSON.stringify(save_data)
	file.store_line(jstr)


func load_game() -> void:
	print("Loading Game...")
	LoadGame.emit(save_data)

func clear_Save() -> void:
	saved_variables.clear()
	save_data.clear()
	saved_node_name = ""
	OS.move_to_trash(ProjectSettings.globalize_path(save_path))
	has_save_file = false

func get_save_file() -> bool:
	if not FileAccess.file_exists(save_path):
		return false
	
	var json_as_text = FileAccess.get_file_as_string(save_path)
	save_data = JSON.parse_string(json_as_text)
	
	if save_data.has("saved_variables"):
		saved_variables = save_data["saved_variables"]
	if save_data.has("saved_node_name"):
		saved_node_name = save_data["saved_node_name"]
	else:
		saved_node_name = ""
	
	if saved_variables.is_empty():
		return false
	return true
