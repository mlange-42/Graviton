extends Area2D

class_name Collectable

func _on_body_entered(body):
	if body.name == "Player":
		body.collect_item(self)

func collected():
	pass
