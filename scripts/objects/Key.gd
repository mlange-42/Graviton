extends Collectable

class_name Key

export (String) var key = null

func get_key() -> String:
	return key

func collected():
	self.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
