extends Control


func _ready():
	$AudioStreamPlayer.play()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/MainGame.tscn")

