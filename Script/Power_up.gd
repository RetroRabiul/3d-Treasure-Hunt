extends Spatial



func _ready():
	pass # Replace with function body.





func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("power_up")
		queue_free()
