extends Node2D
var screensize

signal reset

func _ready():
	screensize = $Johnny.screensize
	$Johnny.connect("morreu", self, "_on_morreu")
#	$Johnny.position = screensize/2
	pass

func _on_morreu():
	print('bananas 2')
	emit_signal("reset")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
