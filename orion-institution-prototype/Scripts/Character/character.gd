extends Node2D
class_name Character

@export var character_name: String
@export var animation_player: AnimationPlayer

func Talk() -> void:
	animation_player.play("talk_jump")

func Leave() -> void:
	self.visible = false
