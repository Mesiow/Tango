extends Sprite

var barrelOffset

func _ready():
	set_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
	
func _process(delta):
	global_position=get_global_mouse_position() + barrelOffset
	pass

func init(gunDirOffset):
	barrelOffset=gunDirOffset
	barrelOffset.y+=16
	barrelOffset.x+=16
	pass