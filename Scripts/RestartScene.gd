extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass


func _on_RestartBtn_pressed():
	get_tree().reload_current_scene()
	pass 


func _on_ExitBtn_pressed():
	get_tree().quit()
	pass
