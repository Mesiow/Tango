extends Node

const Spawner=preload("res://Scenes/ZombieSpawner.tscn")
var spawner
var world

onready var anim=get_node("Label/Animation")
onready var label=get_node("Label")
var waveNumber = 1
var newWave=false

func _ready():
	world=get_tree().get_root().get_node("/root/World")
	waitToSpawn()
	pass
	
	
func _process(delta):
	var zombieGroup=get_tree().get_nodes_in_group("Zombies")
	
	if zombieGroup.size() <= 0: #wave ended
		newWave=true
	if newWave:
		waveNumber+=1
		remove_child(spawner)
		waitToSpawn()
		newWave=false
	pass
	
func waitToSpawn():
	set_process(false)
	setLabel()
	beginWave()
	anim.play("fade")
	yield(get_tree().create_timer(5), "timeout") # wait till zombie timer finishes spawning zombies
	set_process(true)
	pass

	
func setLabel():
	label.text = "Wave "+str(waveNumber)+" starting"
	pass
	
func beginWave():
	spawner=Spawner.instance()
	spawner.amountToSpawn = 2 * waveNumber
	spawner.begin()
	print(spawner.amountToSpawn)
	
	add_child(spawner)
	pass




func _on_Animation_animation_finished(anim_name):
	
	pass
