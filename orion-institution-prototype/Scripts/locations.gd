extends Node2D

var all_locations: Array[Location]
var all_location_names: Array[String]



func _ready() -> void:
	for location: Location in get_children():
		all_locations.append(location)
		all_location_names.append(location.location_name)

func UpdateCharacterLocation(character_name: String, character_location: String) -> void:
	for location: Location in all_locations:
		if location.location_name == character_location:
			location.current_character = character_name
		else:
			if location.current_character == character_name:
				location.current_character = ""

func RemoveCharacterFromAllLocations(character_name:String) -> void:
	for location:Location in all_locations:
		if location.current_character == character_name:
			location.current_character = ""
