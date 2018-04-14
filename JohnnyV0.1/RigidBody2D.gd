extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	pass

func _on_Area2D_body_entered(body):
	
	if body.get_name() == "Johnny":
		$DeathTimer.start()
		


func _on_DeathTimer_timeout():
	queue_free()
	pass # replace with function body
