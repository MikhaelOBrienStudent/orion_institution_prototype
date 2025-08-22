extends Node2D
class_name Location

@export var location_name: String
@export var left_location: Location
@export var right_location: Location
@export var top_location: Location
@export var bottom_location: Location

@export var current_characters: Array[String]

@export var shade_tint: Color = "White"
@export var light_tint: Color = "Black"

var modulator: CanvasModulate
var light: PointLight2D

func _ready() -> void:
	for child in get_children():
		use_parent_material = true
	
	modulator = CanvasModulate.new()
	modulator.color = shade_tint
	add_child(modulator)
	
	#light = light_resource.instantiate()
	#light.color = light_tint
	#add_child(light)
	

func Arrive() -> void:
	visible = true
	#light.color = light_tint

func Leave() -> void:
	visible = false

func ClearCharacters() -> void:
	current_characters.clear()
