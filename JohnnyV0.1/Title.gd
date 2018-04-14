extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal title_out

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)

func _input(event):
	if event is InputEventKey:
		emit_signal("title_out")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
