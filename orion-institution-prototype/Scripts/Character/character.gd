extends Node2D
class_name Character

@export var character_name: String
@export var animation_player: AnimationPlayer

@onready var pose_sprite: Sprite2D = get_node("Pose")
@onready var expression_sprite: Sprite2D = get_node("Expression")

@onready var poses: Node = get_node("Poses")
@onready var expressions: Node = get_node("Expressions")

func _ready() -> void:
	if pose_sprite == null:
		pose_sprite = Sprite2D.new()
		pose_sprite.position = Vector2(946, 1152)
		pose_sprite.name = "Pose"
		add_child(pose_sprite)
	if expression_sprite == null:
		expression_sprite = Sprite2D.new()
		expression_sprite.position = Vector2(0,0)
		expression_sprite.name = "Expression"
		pose_sprite.add_child(expression_sprite)
	
	expression_sprite.reparent(pose_sprite)

func _process(delta: float) -> void:
	expression_sprite.offset = pose_sprite.offset

func Talk() -> void:
	animation_player.play("talk_jump")

func Leave() -> void:
	self.visible = false

func UpdatePose(pose_name: String) -> void:
	for pose: Pose in poses.get_children():
		if pose.name == pose_name:
			pose_sprite.texture = pose.pose_sprite
			return
	push_error("Pose '{0}' not found for {1}. Make sure to check spelling, or that the character has that pose available".format([pose_name, character_name]))

func UpdateFace(expression_name: String) -> void:
	for face: Face in expressions.get_children():
		if face.name == expression_name:
			expression_sprite.texture = face.face_sprite
			return
	push_error("Expression '{0}' not found for {1}. Make sure to check spelling, or that the character has that expression available".format([expression_name, character_name]))
