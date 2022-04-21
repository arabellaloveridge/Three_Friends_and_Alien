extends Control


func _ready():
	$Label.text = "The timer hit 0!\n\nYour final score was: " + str(Global.score)


func _on_Play_Again_pressed():
	Global.score = 0
	Global.time = 10
	get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
