extends Area2D

class_name Interactable

func _on_body_entered(body):
	if body.name == "Player":
		body.area_entered(self)


func _on_body_exited(body):
	if body.name == "Player":
		body.area_exited(self)

func interact(_player):
	pass
	
