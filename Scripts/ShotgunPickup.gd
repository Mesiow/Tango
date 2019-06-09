extends "res://Scripts/Pickup.gd"

func _ready():
	pass



func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.weaponDict["Equipped"]="Shotgun" #set equipped weapon to shotgun
		queue_free()
	pass 
