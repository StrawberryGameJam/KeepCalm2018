extends Node2D
var screensize

signal reset
signal game_over

func _ready():
	screensize = $Johnny.screensize
	$Johnny.connect("morreu", self, "_on_morreu")
	
#	$Johnny.position = screensize/2
	pass

func _process(delta):
	for child in get_children():
		if child.has_user_signal("violanssa"):
			child.connect("violanssa",self,"_on_violence")
			
func _on_violence():
	emit_signal("game_over")

func _on_morreu():
	#print('bananas 2')
	emit_signal("reset")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
