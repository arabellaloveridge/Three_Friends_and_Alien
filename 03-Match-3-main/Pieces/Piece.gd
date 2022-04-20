extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2(0,0)
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)

var fall_speed = 0.75
var move_speed = 1.0

var dying = false
var dying_progress = 0

func _ready():
	randomize()

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
	if not dying and target_position != Vector2.ZERO and not $Moving.is_active() and target_position != position:
		$Moving.interpolate_property(self, "position", position, target_position, move_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		$Moving.start()
	if selected:
		$Selected.emitting = true
		$Select.show()
		z_index = 10
	else:
		$Selected.emitting = false
		$Select.hide()
		z_index = 1
		

func move_piece(change):
	target_position = position + change
	
func move_piece_to(change):
	target_position = change

func die():	
	dying = true
	var target_color = $Sprite.modulate
	target_color.s = 1
	target_color.h = randf()
	target_color.a = 0.25
	var fall_duration = randf()*fall_speed + 1
	var rotate_amount = (randi()%1440) - 720
	
	var target_pos = position
	target_pos.y = 1100
	if randf() < 0.5:
		$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotate_amount, fall_duration-0.25, Tween.TRANS_QUINT, Tween.EASE_IN)
		$Tween.start()
	else:
		fall_duration = 1.0
		$Tween.interpolate_property(self, "scale", scale, Vector2(2,2), fall_duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()
		target_color.h = 0
		$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
