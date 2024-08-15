extends Node2D

func _ready():
	pass

func _on_play_button_pressed():
	get_tree().change_scene("res://Scene/Game_Scene.tscn")
