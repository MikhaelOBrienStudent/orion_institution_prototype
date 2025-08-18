extends Node
class_name SaveData

@export var memory_storage: InMemoryVariableStorage
var local_variables: Dictionary

var last_key: String

func _ready() -> void:
	SaveManagement.SaveGame.connect(update_local_save)
	SaveManagement.LoadGame.connect(update_in_memory_variable_storage)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		update_local_save()

func update_local_save() -> void:
	memory_storage.GetSaveData()
	SaveManagement.saved_variables = local_variables

func update_in_memory_variable_storage(load_data: Dictionary) -> void:
	local_variables = SaveManagement.saved_variables
	memory_storage.Clear()
	print("Loading saved variables...")
	print("------------------------")
	for variable in local_variables:
		memory_storage.SetValue(variable, local_variables[variable])
		print(variable)
		print(local_variables[variable])
	print("------------------------")
	print("Variables loaded!")

func _on_in_memory_variable_storage_send_variable_key(variable_key: String) -> void:
	last_key = variable_key


func _on_in_memory_variable_storage_send_variable_float(float_variable: float) -> void:
	local_variables[last_key] = float_variable
	


func _on_in_memory_variable_storage_send_variable_bool(bool_variable: bool) -> void:
	local_variables[last_key] = bool_variable


func _on_in_memory_variable_storage_send_variable_string(string_variable: String) -> void:
	local_variables[last_key] = string_variable
