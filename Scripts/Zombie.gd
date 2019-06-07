extends KinematicBody2D

var motion=Vector2()
export var movementSpeed=120

var reactTime=900
var direction=Vector2()
var nextDir=Vector2()
var nextDirTime=0

var health=10 setget setHealth, getHealth
var attacking=false
var attackDmg=10

onready var player=get_parent().get_node("Player") #get access to the player

func _ready():
	set_process(true)
	$AnimatedSprite.play("idle")
	add_to_group("Zombies")
	pass
	
func spawn(position):
	global_position=position
	pass

func _process(delta):
	look_at(player.global_position)
	#follow player
	
	if attacking:
		player.health-=1
		print(player.health)
		
	if (motion > Vector2(0,0) or motion < Vector2(0,0)) and !attacking:
		$AnimatedSprite.play("move")
		
	var dir=(player.global_position - global_position).normalized()
	
	motion=dir * movementSpeed
	move_and_slide(motion)
	pass
	

func _on_AttackArea_body_entered(body):
	if body.get_name() == "Player":
		attacking=true
		$AnimatedSprite.stop()
		$AnimatedSprite.play("attack")
	pass


func _on_AttackArea_body_exited(body):
	if body.get_name() == "Player":
		attacking=false
	pass 
	
func setHealth(newHealth):
	if newHealth <= 0:
		queue_free()#zombie is dead
	health=newHealth
	pass
	
func getHealth():
	return health
	pass
