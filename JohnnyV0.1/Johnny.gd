extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0,-1)

export (int) var GRAVITY = 1000 # pixels/second²
export (float) var JUMPSPEED = 500 # pixels/second
export (int) var MAXSPEED = 300 # pixels/second
export (String) var TYPE = "player"

var velocity
var screensize
var face_last

signal morreu

func _ready():
	screensize = get_viewport_rect().size
	face_last = "right"
	velocity = Vector2(0,0)

func _process(delta):
	if not is_on_floor():

		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_h = face_last == "left"
		
	elif velocity.x != 0:
		$AnimatedSprite.animation = "walking_right"
		$AnimatedSprite.flip_h = face_last == "left"

	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.flip_h = face_last == "left"
	#print($AnimatedSprite.animation , face_last)
	

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = MAXSPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -MAXSPEED
	else:
		velocity.x = 0
	#print (prevy)
	
	if is_on_floor():
		velocity.y = 15
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMPSPEED
			
	move_and_slide(velocity, UP)
	if velocity.x > 0:
		face_last = "right"
	elif velocity.x < 0:
		face_last = "left"
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y*2)

func reset():
	print("bananas")
	emit_signal("morreu")

func hit_by_enemy(enemy):
	reset()
	
func fell():
	reset()
