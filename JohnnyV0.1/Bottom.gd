extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func body_entered(body):
	if body.has_method("fell"):
		body.fell()

func _on_Bottom_body_entered(body):
	pass # replace with function body
