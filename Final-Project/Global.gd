extends Node

var score = 0
var time = 10

signal score_changed
signal time_changed

var scores = {
	0:0,
	1:0,
	2:0,
	3:10,
	4:20,
	5:50,
	6:100,
	7:200,
	8:300,
	9:1000
}

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
		

func change_score(s):
	var camera = get_node_or_null("/root/Game/Camera")
	if camera != null:
		camera.add_trauma(0.5)
	score += s
	add_time()
	emit_signal("score_changed")
	
func change_time():
	time -= 1
	emit_signal("time_changed")
	
	if time <= 0:
		get_tree().change_scene("res://Screens/End_Game.tscn")
	
func add_time():
	time += 2
	emit_signal("time_changed")

