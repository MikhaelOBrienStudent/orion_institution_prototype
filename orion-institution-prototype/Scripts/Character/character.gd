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
	
	modulate.a = 0


func Talk() -> void:
	var jump_tween = self.create_tween()
	jump_tween.set_parallel()
	jump_tween.tween_property(pose_sprite, "offset", Vector2(0,-30), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	jump_tween.tween_property(expression_sprite, "offset", Vector2(0,-30), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	await jump_tween.finished
	
	
	var jump_tween_2 = self.create_tween()
	jump_tween_2.set_parallel()
	jump_tween_2.tween_property(pose_sprite, "offset", Vector2(0,0), 0.075).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	jump_tween_2.tween_property(expression_sprite, "offset", Vector2(0,0), 0.075).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	#animation_player.play("talk_jump")

func Highlight(talking:bool = true) -> void:
	if talking:
		self.z_index = 1
		scale = Vector2(1.1,1.1)
		position.y = -60
		modulate = Color(1, 1, 1, modulate.a)
		return
	self.z_index = 0
	scale = Vector2(1,1)
	position.y = 0
	modulate = Color(0.7, 0.8, 0.9, modulate.a)

func Arrive() -> void:
	self.visible = true
	var arrive_tween = create_tween()
	arrive_tween.tween_property(self, "modulate:a", 1, 0.25)
	await arrive_tween.finished

func Leave() -> void:
	var leave_tween = create_tween()
	leave_tween.tween_property(self, "modulate:a", 0, 0.25)
	await leave_tween.finished
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
