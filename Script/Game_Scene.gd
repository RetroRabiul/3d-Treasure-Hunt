extends Spatial


var rng = RandomNumberGenerator.new()


func _ready():
	GlobalVars.time = 0
	rng.randomize()
	_key_random_pos()


func _key_random_pos():
	var position_count = $"%Key_position".get_child_count() - 1
	var random_pos = rng.randi_range(0, position_count)
	var key_pos = $"%Key_position".get_child(random_pos)
	$"%key".global_position = key_pos.global_position
	


func _on_Restart_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Scene/Game_Scene.tscn")
		GlobalVars.key_collected = false
		GlobalSignal.emit_signal("lost_key")
		call_deferred("_key_random_pos")
		
