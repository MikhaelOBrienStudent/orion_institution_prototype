extends Node

@export var start_menu: CanvasLayer
@export var pause_menu: CanvasLayer
@export var world_scene: PackedScene
var world

var is_paused: bool = false
var is_playing: bool = false

#@export var gui: CanvasLayer
#@export var scene_temp: Node

var PlayerName: String = ""

func _ready() -> void:
	pass

func start_game() -> void:
	world = world_scene.instantiate()
	add_child(world)
	start_menu.hide()
	start_menu.process_mode = Node.PROCESS_MODE_DISABLED
	is_playing = true

func go_to_menu() -> void:
	world.queue_free()
	start_menu.show()
	start_menu.process_mode = Node.PROCESS_MODE_INHERIT
	is_playing = false
	pause_game(false)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func pause_game(is_pausing: bool) -> void:
	if is_pausing:
		get_tree().paused = true
		pause_menu.show()
		is_paused = true
		return
	
	get_tree().paused = false
	pause_menu.hide()
	is_paused = false

func _unhandled_key_input(event: InputEvent) -> void:
	if not is_playing:
		return
	if event.is_action_pressed("BACK"):
		if not is_paused: pause_game(true)
		else: pause_game(false)
