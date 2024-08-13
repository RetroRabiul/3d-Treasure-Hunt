extends StaticBody

var door_closed = true

var player_near = false
 
export var locked = false

func _ready():
	pass

func _use_door():
	if door_closed:
		$"%DoorAnim".play("open")
		door_closed = false
	else:
		$"%DoorAnim".play("close")
		door_closed = true


func _input(event):
	if event.is_action_pressed("use"):
		if player_near:
			_use_door()



func _on_DoorArea_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		GlobalSignal.emit_signal("can_use", true)
	


func _on_DoorArea_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
		GlobalSignal.emit_signal("can_use", false)
