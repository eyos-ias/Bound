extends Node2D

var p1_entered = false
var p2_entered = false

export (String) var load_screen_name = null

func _ready():
	load_screen()

func load_screen():
	if load_screen_name != null:
		get_tree().call_group("ui", "show_chapter", load_screen_name) 

func _on_LevelExit_body_entered(body):
	if body.name == "PlayerBase2":
		p2_entered = true
		if p1_entered:
			get_tree().call_group("MainGame", "next_level")
	else:
		p2_entered = false

func _on_LevelExit2_body_entered(body):
	if body.name == "PlayerBase":
		p1_entered = true
		if p2_entered:
			get_tree().call_group("MainGame", "next_level")
	else:
		p1_entered = false
