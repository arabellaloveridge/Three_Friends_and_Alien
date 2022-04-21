extends Node2D

onready var music_normal = get_node("/root/Game/Music_Normal")
onready var music_fast = get_node("/root/Game/Music_Fast")

func _ready():
	check_music()
	
func check_music():
	if Global.time >= 4:
		music_normal.playing = true
		music_fast.playing = false
	if Global.time <= 3:
		music_normal.playing = false
		music_fast.playing = true
	
