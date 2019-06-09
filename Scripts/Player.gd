extends KinematicBody2D

const BulletScene=preload("res://Scenes/Bullet.tscn")
const MuzzleFlashScene=preload("res://Scenes/MuzzleFlash.tscn")

onready var anim=get_node("AnimatedSprite")

var motion=Vector2()
var movementSpeed=150

var meleeState=false
var shootingState=false
var health=100 setget setHealth, getHealth
var died=false
var canShoot=true

var weaponDict = {}
var equipped setget setWeapon, getWeapon

func _ready():
	set_process(true)
	set_process_input(true)
	weaponDict["Equipped"]="Handgun"
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
		determineMovementAnim()
	
	if event.is_action_released("Up") or event.is_action_released("Down"):
		motion.y=0
	if event.is_action_released("Left") or event.is_action_released("Right"):
		motion.x=0
	else:
		if !shootingState:
			determineIdleAnim()

	pollAttack(event)
	pass
	
func determineMovementAnim():
	if weaponDict["Equipped"] == "Handgun":
		anim.play("moving_handgun")
	elif weaponDict["Equipped"] == "Shotgun":
		anim.play("moving_shotgun")
	pass
	
func determineIdleAnim():
	if weaponDict["Equipped"] == "Handgun": #if equipped weapon is a handgun
		anim.play("idle_handgun")
	elif weaponDict["Equipped"] == "Shotgun":
		anim.play("idle_shotgun")
	pass
	
func determineShootingAnim():
	if weaponDict["Equipped"] == "Handgun":
		anim.play("shoot_handgun")
		$Gun/HandGunShot.play()
		$Gun/ShootTimerHandGun.start()
	elif weaponDict["Equipped"] == "Shotgun":
		anim.play("shoot_shotgun")
		$Gun/ShotgunShot.play()
		$Gun/ShootTimerShotgun.start()
	pass
	
func pollAttack(event):
	#shooting
	if event.is_action_pressed("shoot"):
		if canShoot:
			shootingState=true
			anim.stop()
			determineShootingAnim()
			fireGun()
			canShoot=false
	pass

func fireGun():
	randomize()
	var world=get_tree().get_root().get_node("/root/World")
	
	var bullet=BulletScene.instance()
	var muzzleNode=get_node("Gun/GunMuzzle")
	var muzzleGlobalPos=muzzleNode.global_position
	var muzzleLocalPos=muzzleNode.position
	var direction=($Gun/GunDirection.global_position - muzzleGlobalPos).normalized()
	
	if weaponDict["Equipped"] == "Handgun":
		bullet.spawn(muzzleGlobalPos, direction)
		world.add_child(bullet)
	elif weaponDict["Equipped"] == "Shotgun":
		bullet.spawn(muzzleGlobalPos, direction) #center shell
		for i in range(0, 4): #spawn 4 shells
			var shotgunBullet=BulletScene.instance()
			var randAngle=rand_range(-0.5, 0.5)
			var rotatedDir = direction.rotated(randAngle)
			shotgunBullet.spawn(muzzleGlobalPos, rotatedDir)
			world.add_child(shotgunBullet)
	
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
	
func setWeapon(newWeapon):
	
	pass
	
func getWeapon():
	return equipped
	pass


func _on_ShootTimerShotgun_timeout():
	canShoot=true
	pass
