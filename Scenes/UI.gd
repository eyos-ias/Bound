extends Control
 

func _ready():
#	show_chapter("Instant")
	pass

func show_chapter(chapter):
	var chap = get_node(chapter)
	var lbl = chap.get_child(0)
	chap.show()
	Globals.tween_active = true
	tween_lable(lbl)
	yield($Tween, "tween_completed")
	yield(get_tree().create_timer(1), "timeout")
	tween_rect(chap)
	yield($Tween, "tween_completed")
	chap.hide()
	Globals.tween_active = false
	
func tween_rect(_chap):
	$Tween.interpolate_property(_chap, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func tween_lable(lbl_name):
	$Tween.interpolate_property(lbl_name, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
