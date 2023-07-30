extends Node

const BGM = "BGM"
const SFX = "SFX"

var sound_list = {
	"music" : {"file_path" : "res://Audio/Music/Wintergatan.ogg", "type" : BGM, "volume" : 1},
}

var audio_players = {}

var playing_bgm = []
var playing_sfx = []
var playing_sounds = []

func _ready():
	# Add Audiobusses for SFX and Music
	if AudioServer.get_bus_index(SFX) == -1:
		AudioServer.add_bus()
		AudioServer.set_bus_name(AudioServer.bus_count-1, SFX)
	
	if AudioServer.get_bus_index(BGM) == -1:
		AudioServer.add_bus()
		AudioServer.set_bus_name(AudioServer.bus_count-1, BGM)
	
	generate_audio_players()


func generate_audio_players():
	# Generate a Audioplayer for every Sound
	for sound_name in sound_list:
		var sound_info = sound_list[sound_name]
		var player = preload("MyAudioStreamPlayer.tscn").instantiate()
		player.finished.connect(
			func(): 
				playing_sounds.erase(sound_name)
				playing_bgm.erase(sound_name)
				playing_sfx.erase(sound_name)
				)
		player.bus = sound_info.type
		player.set_stream(load(sound_info.file_path))
		player.sound_type = sound_info.type
		player.volume_db = linear_to_db(sound_info.volume)
		add_child(player)
		audio_players[sound_name] = player


func play(sound_name:String, multiple:bool = true):
	if !audio_players.keys().has(sound_name):
		return
		
	var player = audio_players[sound_name]
	
	match player.sound_type:
		BGM: playing_bgm.append(player)
		SFX: playing_sfx.append(player)
	playing_sounds.append(sound_name)
	
	if player.playing && multiple:
		var asp = player.duplicate(DUPLICATE_USE_INSTANTIATION)
		get_parent().add_child(asp)
		asp.stream = player.stream
		asp.play()
		
		await asp.finished
		playing_sounds.erase(sound_name)
		playing_bgm.erase(sound_name)
		playing_sfx.erase(sound_name)
		asp.queue_free()
	else:
		player.play()


func stop(sound_name : String):
	audio_players[sound_name].stop()


func fade_in(sound_name:String, time:float, to_volume = null):
	if !audio_players.keys().has(sound_name):
		return
	var player = audio_players[sound_name]
	match player.sound_type:
		BGM: playing_bgm.append(player)
		SFX: playing_sfx.append(player)
	playing_sounds.append(sound_name)
	
	if to_volume == null:
		player.fade_in(time, sound_list[sound_name].volume)
	else:
		player.fade_in(time, to_volume)
	
func fade_out(sound_name:String, time:float):
	pass

# value is a float between 0 and 1
func change_bus_volume(bus_name:String, value:float):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db)
