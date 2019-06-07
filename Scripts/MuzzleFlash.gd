extends Sprite

func _ready():
	$MuzzleFade.play("Fade")
	pass

func spawn(pos):
	global_position=pos
	pass

func _on_MuzzleFade_animation_finished(anim_name):
	if anim_name == "Fade":
		queue_free()
	pass
