extends KinematicBody2D

var motion=Vector2()
export var movementSpeed=120

const bloodParticles=preload("res://Scenes/BloodParticles.tscn")

var reactTime=900
var direction=Vector2()
var nextDir=Vector2()
var nextDirTime=0

var health=10 setget setHealth, getHealth
var attacking=false
var attackDmg=10
var passive=false

func _ready():
	set_process(true)
	$AnimatedSprite.play("idle")
	add_to_group("Zombies")
	pass
	
func spawn(position):
	global_position=position
	pass

func _process(delta):
	var player=get_parent().get_node("Player") #access player
	if player != null:
		look_at(player.global_position)
	#follow player
	
	if attacking:
		if player!=null:
			player.health-=1
		
	if (motion > Vector2(0,0) or motion < Vector2(0,0)) and !attacking:
		$AnimatedSprite.play("move")
	
	if player!=null:
		var dir=(player.global_position - global_position).normalized()
		motion=dir * movementSpeed
	else:
		(passive=true if false else false)
		
	if passive and player == null:
		movementSpeed=movementSpeed - movementSpeed *0.5 #half the speed
		var randDirX=rand_range(0, get_viewport_rect().size.x) #get a random direction for the zombie to passively move in
		var randDirY=rand_range(0, get_viewport_rect().size.y)
		var dir=(Vector2(randDirX, randDirY) - global_position).normalized()
		motion=dir * movementSpeed
		passive=false
	
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
		remove_from_group("Zombies")
		queue_free()#zombie is dead
	health=newHealth
	pass
	
func getHealth():
	return health
	pass


func _on_AttackArea_area_entered(area):
	if area.get_name() == "Bullet":
		var blood=bloodParticles.instance()
		add_child(blood)
	pass
