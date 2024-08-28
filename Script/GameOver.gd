extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("player_time", self, "_player_time")
	GlobalSignal.connect("long_time", self, "_long_time")
	_player_time()
	

func _long_time():
	$"%Time".text = "It's been too long"
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _player_time():
	$"%Time".text = "Your Time : " + str(GlobalVars.time)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print(GlobalVars.time)

func _on_back_button_pressed():
	get_tree().change_scene("res://Scene/main_menu.tscn")
	GlobalVars.time = 0
