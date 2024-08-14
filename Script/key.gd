extends Spatial




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Collectkey_body_entered(body):
	if body.is_in_group("player"):
		GlobalVars.key_collected = true
		GlobalSignal.emit_signal("got_key")
		queue_free()
