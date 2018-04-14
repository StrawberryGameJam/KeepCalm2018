extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0,-1)

export (int) var GRAVITY = 1000 # pixels/second²
export (float) var JUMPSPEED = 500 # pixels/second
export (int) var MAXSPEED = 300 # pixels/second
export (String) var TYPE = "enemy"

var velocity
var screensize
var face_last
var distance

var is_pushing

signal violanssa

func _ready():
	is_pushing = false
	face_last = "right"
	velocity = Vector2(0,0)
	$AnimatedSprite.connect("animation_finished",self,"_on_push_end")

func push():
	$AnimatedSprite.animation = "pushing"
	is_pushing = true

func _on_push_end():
	if $AnimatedSprite.animation == "pushing":
		is_pushing = false
		

func _process(delta):
	if is_pushing == false:
		if not is_on_floor():
	
			$AnimatedSprite.animation = "jump"
			$AnimatedSprite.flip_h = face_last == "left"
			
		elif velocity.x != 0:
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = face_last == "left"
			if face_last == "left":
				$AnimatedSprite.offset.x = -30
			else:
				$AnimatedSprite.offset.x = 30
		
	#print($AnimatedSprite.animation , face_last)
	pass

func _physics_process(delta):
	
	
	var player_position = Vector2(0,0)
	
	for things in get_owner().get_children():
		if things.is_in_group("Player"):
			#things.get_child("Position2D").get_pos()
			player_position = things.position
			break
			
	var my_position = position
	
	distance = my_position - player_position
	
	if is_pushing == false:
		if distance.x < -100:
			velocity.x = MAXSPEED
		elif distance.x > 100:
			velocity.x = -MAXSPEED
		#print (prevy)
		
		elif distance.y >= -100 and distance.y <= 100:
			push()
	
	if is_pushing == false:
		velocity.y += GRAVITY*delta
		if is_on_floor():
			velocity.y = 15
				
		move_and_slide(velocity, UP)
		if velocity.x > 0:
			face_last = "right"
		elif velocity.x < 0:
			face_last = "left"
		#position.x = clamp(position.x, 0, screensize.x)
		#position.y = clamp(position.y, 0, screensize.y*2)

func reset():
	queue_free()

func hit_by_player(enemy):
	emit_signal("violanssa")
	reset()
	
func fell():
	reset()
