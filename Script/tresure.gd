extends Spatial

var player_near = false

func _ready():
	$Lock.visible = true
	GlobalSignal.connect("use_treasure", self, "_use_treasure")

func _use_treasure():
	if player_near:
		GlobalSignal.emit_signal("player_time")
		print("teasure_opened")
		$AnimationPlayer.play("open")
		$Lock.visible = false
		yield($AnimationPlayer, "animation_finished")
		call_deferred("_change_scene")
		

func _change_scene():
	get_tree().change_scene("res://Scene/GameOver.tscn")


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		if GlobalVars.key_collected:
			GlobalSignal.emit_signal("sign_text", "Prees E")
		else:
			GlobalSignal.emit_signal("sign_text", "Search For The Key")


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
		GlobalSignal.emit_signal("sign_hide")
