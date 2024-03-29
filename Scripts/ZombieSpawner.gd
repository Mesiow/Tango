extends Node

const Zombie=preload("res://Scenes/Zombie.tscn")
export var amountToSpawn = 1

func _ready():
	pass
	
func begin():
	$Timer.start()
	pass
	
	
func spawn():
	randomize()
	$ZombiePath/Location.offset=randi()#set random offset for the path
	
	var zombie=Zombie.instance()
	
	var dir=$ZombiePath/Location.rotation + PI / 2
	
	zombie.global_position=$ZombiePath/Location.global_position
	
	get_tree().get_root().get_node("/root/World").add_child(zombie)
	pass


func _on_Timer_timeout():
	for i in range(0, amountToSpawn):
		spawn()
	pass
