extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("player_time", self, "_player_time")
	_player_time()
	

func _player_time():
	$"%Time".text = "Your Time : " + str(GlobalVars.time)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print(GlobalVars.time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
