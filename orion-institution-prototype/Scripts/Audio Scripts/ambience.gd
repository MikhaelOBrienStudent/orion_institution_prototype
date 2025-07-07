extends Node

@export var ambient_clips: Array[AudioStream]
var clip_playlist: AudioStreamRandomizer
@export var volume: float = 1.0

@export var audio_player_1: AudioStreamPlayer
#@export var audio_player_2: AudioStreamPlayer



func _ready() -> void:
	clip_playlist = AudioStreamRandomizer.new()
	for clip in ambient_clips:
		clip_playlist.add_stream(-1, clip)
	audio_player_1.stream = clip_playlist
	audio_player_1.volume_linear = volume
	audio_player_1.play()
