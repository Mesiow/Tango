extends TextureProgress

var maxHealth=100
var currentHealth = 100 setget, getCurrentHealth

func _ready():
	value=maxHealth
	#Tween effect happening on the value property
	#starting with current value and then end value then the duration (0.5 seconds)
	#and we use the Tween functions quad and ease in for the effect
	#$fillEffect.interpolate_property($LifeBar, "Range/Value", #TODO: fix tween
	#value, 100, 0.5, Tween.TRANS_QUAD, Tween.EASE_IN)
	#$fillEffect.start()
	pass


func _on_Interface_healthChanged(health):
	value = health
	currentHealth=health
	pass 
	
func getCurrentHealth():
	return currentHealth
	pass
