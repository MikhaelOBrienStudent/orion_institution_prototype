extends Node

var sound_clips: Array[AudioStream]
var sound_clip_names: Array[String]

var UI_player: AudioStreamPlayer
var World_player: AudioStreamPlayer

enum sfx_type {
	UI,
	WORLD
}

func _init() -> void:
	pass#get_sound_files()



##Depreciated, used initially for the method where the name of the file was added instead of the file itself. 
func get_sound_files():# -> Array[AudioStream]:
	var path = "res://Audio/SFX Clips"
	var audio_files: PackedStringArray = DirAccess.get_files_at(path)
	
	for file_path in audio_files:
		if not file_path.ends_with(".remap") && not file_path.ends_with(".import"):
			var audio_clip: AudioStream = load(path + "/" + file_path)
			var audio_name = file_path.get_basename().get_file()
			
			sound_clips.append(audio_clip)
			sound_clip_names.append(audio_name)


func PlaySound(clip: AudioStream, volume: float, bus:sfx_type):
	#var clip: AudioStream = sound_clips[sound_clip_names.find(clip_name)]
	var sound = AudioStreamPlayer.new()
	sound.stream = clip
	sound.volume_linear = volume
	if bus == sfx_type.UI:
		sound.bus = "UI_SFX"
	elif bus == sfx_type.WORLD:
		sound.bus = "World_SFX"
	
	add_child(sound)
	sound.play()
	await sound.finished
	sound.queue_free()
