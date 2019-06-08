extends KinematicBody2D

const BulletScene=preload("res://Scenes/Bullet.tscn")
const MuzzleFlashScene=preload("res://Scenes/MuzzleFlash.tscn")

var motion=Vector2()
var movementSpeed=150

var meleeState=false
var shootingState=false
var health=100 setget setHealth, getHealth
var died=false
var canShoot=true

func _ready():
	set_process(true)
	set_process_input(true)
	pass
	
	
func _process(delta):
	look_at(get_global_mouse_position())
	move_and_slide(motion)
	pass
	
func _input(event):
	
	#Y movement
	if event.is_action_pressed("Up"):
		motion.y = -movementSpeed
	elif event.is_action_pressed("Down"):
		motion.y = movementSpeed

		
	#X movement
	if event.is_action_pressed("Left"):
		motion.x = -movementSpeed
	elif event.is_action_pressed("Right"):
		motion.x = movementSpeed
	
	if (motion > Vector2(0,0) or motion < Vector2(0,0)) and !shootingState:
		$AnimatedSprite.play("moving")
	
	if event.is_action_released("Up") or event.is_action_released("Down"):
		motion.y=0
	if event.is_action_released("Left") or event.is_action_released("Right"):
		motion.x=0
	else:
		if !shootingState:
			$AnimatedSprite.play("idle")

	pollAttack(event)
	pass
	
func pollAttack(event):
	#shooting
	if event.is_action_pressed("shoot"):
		if canShoot:
			shootingState=true
			$AnimatedSprite.stop()
			$AnimatedSprite.play("shoot_handgun")
			fireGun()
			$Gun/HandGunShot.play()
			$Gun/ShootTimer.start()
			canShoot=false
	pass

func fireGun():
	var bullet=BulletScene.instance()
	var muzzleNode=get_node("Gun/GunMuzzle")
	var muzzleGlobalPos=muzzleNode.global_position
	var muzzleLocalPos=muzzleNode.position
	
	var direction=($Gun/GunDirection.global_position - muzzleGlobalPos).normalized()
	bullet.spawn(muzzleGlobalPos, direction)
	
	get_tree().get_root().get_node("/root/World").add_child(bullet)
	
	var flash=MuzzleFlashScene.instance()
	flash.spawn(muzzleLocalPos)
	add_child(flash)
	pass

func _on_AnimatedSprite_animation_finished():
	shootingState=false
	pass
	
func setHealth(newHealth):
	if newHealth <= 0:
		died=true
		queue_free()
	health=newHealth
	pass
	
func getHealth():
	return health
	pass


func _on_ShootTimer_timeout():
	canShoot=true
	pass 


func _on_Player_tree_exiting():
	self=null
	pass
