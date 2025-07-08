extends Node2D
class_name Location

@export var location_name: String
@export var left_location: Location
@export var right_location: Location
@export var top_location: Location
@export var bottom_location: Location

@export var current_character: String

func Arrive() -> void:
	visible = true

func Leave() -> void:
	visible = false
