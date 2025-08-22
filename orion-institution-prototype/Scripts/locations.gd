extends Node2D

var all_locations: Array#[Location]
var all_location_names: Array[String]

@export var light: PointLight2D


func _ready() -> void:
	print("Locations initialising")
	if all_locations.is_empty():
		for child in get_children():
			all_locations.append(child)
			all_location_names.append(child.location_name)
			print(child)
		#for location: Location in all_locations:
			#location.light = light
	
	SaveManagement.SaveGame.connect(Save)
	SaveManagement.LoadGame.connect(Load)

func UpdateCharacterLocation(character_name: String, character_location: String) -> void:
	for location: Location in all_locations:
		if location.location_name == character_location && not location.current_characters.has(character_name):
			location.current_characters.append(character_name)
		else:
			location.current_characters.erase(character_name)

func RemoveCharacterFromAllLocations(character_name:String) -> void:
	for location:Location in all_locations:
		location.current_characters.erase(character_name)

func SetLocation(location_name: String) -> Location:
	print("----")
	print("Attempting to set location...")
	if all_locations.is_empty():
		for child in get_children():
			if child.is_class("Location"):
				all_locations.append(child)
				all_location_names.append(child.location_name)
				print(child)
		#for location: Location in all_locations:
			#location.light = light
		
	for location: Location in all_locations:
		print("Checking {0}".format([location]))
		if location.location_name == location_name:
			print("Setting location: {0}".format([location_name]))
			print("----")
			return location
	print("Failed to set location.")
	print("----")
	return null

func Save() -> void:
	var current_location_name: String
	
	var character_locations: Dictionary
	var index: int = 0
	for loc: Location in all_locations:
		character_locations[all_location_names[index]] = loc.current_characters
		if loc.visible:
			current_location_name = all_location_names[index]
		index += 1
		
	
	var save_data: Dictionary = {
		"character_locations":character_locations,
		"current_location": current_location_name
	}
	
	SaveManagement.add_save_data("locations", save_data)

func Load(load_data:Dictionary) -> void:
	return
	if not load_data.has("locations"):
		return
	var location_data: Dictionary = load_data["locations"]["character_locations"]
	print(location_data)
	
	for loc in all_locations:
		loc.current_characters.assign(location_data[loc.location_name])
		print(loc.current_characters)
