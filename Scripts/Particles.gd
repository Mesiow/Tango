extends Node2D

func _ready():
	randomize()
	var children=get_children() #get array of children
	for child in range(0, children.size()):
		children[child].restart()
		children[child].amount=randi() %60 + 10 #spawn random particle amount from 50 to 200
		children[child].one_shot=true
		children[child].emitting=true
	pass
