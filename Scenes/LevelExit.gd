extends Area2D

export (bool) var flip = false

func _ready():
	if flip:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
func _on_LevelExit_body_entered(body):
	pass
