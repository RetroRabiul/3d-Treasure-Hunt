extends Spatial

var player_near = false

func _ready():
	
	GlobalSignal.connect("use_treasure", self, "_use_treasure")

func _on_treasure_area_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		GlobalSignal.emit_signal("sign_text", "Prees E")

func _use_treasure():
	if player_near:
		print("teasure_opened")
		$AnimationPlayer.play("open")


func _on_treasure_area_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
		GlobalSignal.emit_signal("sign_hide")
