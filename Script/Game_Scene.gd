extends Spatial


var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	_key_random_pos()


func _key_random_pos():
	var position_count = $"%Key_position".get_child_count() - 1
	var random_pos = rng.randi_range(0, position_count)
	var key_pos = $"%Key_position".get_child(random_pos)
	$"%key".global_position = key_pos.global_position
