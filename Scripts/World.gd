extends Node

const restartScene=preload("res://Scenes/RestartScene.tscn")

func _ready():
	set_process(true)
	pass 
	
func _process(delta):
	pass


func _on_Player_died():
	var restart=restartScene.instance()
	add_child(restart)
	pass
