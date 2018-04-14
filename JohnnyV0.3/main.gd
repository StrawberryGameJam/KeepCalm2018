extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (PackedScene) var LEVEL
var TITLE = load("res://Title.tscn")


func _ready():
	var title = TITLE.instance()
	title.connect("title_out",self,"_on_start")
	add_child(title)
	
	
	#set_process_input(true)

	pass

func _on_start():
	$TitleScreen.queue_free()
	
	var level = LEVEL.instance()
	level.connect("reset",self,"_on_reset")
	
	add_child(level)


#func _input(event):
#	if event is InputEventKey:
#		print(event.scancode)

func _on_reset():
	#print('bananas3')
	for child in get_children():
		if child.is_in_group("level"):
			child.queue_free()

	var title = TITLE.instance()
	title.connect("title_out",self,"_on_start")
	add_child(title)

func _process(delta):
	pass
