extends Node2D

var all_locations: Array[Location]
var all_location_names: Array[String]



func _ready() -> void:
	for location: Location in get_children():
		all_locations.append(location)
		all_location_names.append(location.location_name)


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
	for location: Location in all_locations:
		if location.location_name == location_name:
			return location
	return null
