extends Node2D

const path = "res://Scenes/Levels/Level%d.tscn"

var lvl = 1

func _ready():
	$AudioStreamPlayer.play()
	call_deferred("init")
	
func init():
	load_lvl(lvl)

func load_lvl(lvl_num):
	if lvl_num == 11:
		get_tree().change_scene("res://Scenes/TBC.tscn") 
	var root = get_tree().root.get_child(1).get_child(0)
#	print(root.name)
	if root.has_node("BaseLevel"):
		var curr_lvl = root.get_node("BaseLevel")
		root.remove_child(curr_lvl)
		curr_lvl.queue_free()

	var level_name = load(path % lvl_num)
	if level_name != null:
		var level = level_name.instance()
		root.add_child(level)
		return true

func screen_fade_out():
	$Tween.interpolate_property($ColorRect, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func screen_fade_in():
	$Tween.interpolate_property($ColorRect, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func next_level():
	lvl += 1
	screen_fade_in()
	Globals.tween_active = true
	yield($Tween, "tween_completed")
	load_lvl(lvl)
	yield(get_tree().create_timer(0.5), "timeout")
	screen_fade_out()
	yield($Tween, "tween_completed")
	Globals.tween_active = false
