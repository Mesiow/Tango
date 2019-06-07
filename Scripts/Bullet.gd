extends Area2D


export var speed=250
export var damage=5
var direction=Vector2()

onready var trail=get_node("Trail")
var trailLength=5
var point

var currTime=0
var life=20

func _ready():
	set_process(true)
	pass 
	
	
func _process(delta):
	currTime+=delta
	if currTime >= life:
		queue_free()
	#bullet trail
	trail.global_position=Vector2(0,0)
	trail.rotation=0
	point=global_position
	trail.add_point(point)
	while trail.get_point_count() > trailLength: #remove trail after length is exceeded
		trail.remove_point(0)
		
	translate(speed * direction * delta)
	pass
	
func spawn(position, dir):
	global_position=position
	direction=dir
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass 


func _on_Bullet_body_entered(body):
	if body.is_in_group("Zombies"):
		body.health-=damage
	pass
