extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0,-1)

export (int) var GRAVITY = 1000 # pixels/second²
export (float) var JUMPSPEED = 500 # pixels/second
export (int) var ACCELERATION = 3000 # pixels/second²
export (int) var MAXSPEED = 300 # pixels/second
export (String) var TYPE = "player"

var velocity
var screensize
var face_last

var normalMax

var push_velocity
var was_pushed

var is_punching

signal morreu

func _ready():
	was_pushed = false
	is_punching = false
	screensize = get_viewport_rect().size
	face_last = "right"
	velocity = Vector2(0,0)
	$Fist.connect("area_entered",self,"_on_area_enter_fist")
	$Fist.connect("body_entered",self,"_on_body_enter_fist")
	$AnimatedSprite.connect("animation_finished",self,"_on_action_end")

func _on_area_enter_fist(area):
	if area.has_method("_get_hit"):
		area.get_hit()
		
func _on_body_enter_fist(body):
	print(body.get_name())
	if body.is_in_group("enemy"):
		emit_signal("morreu")
	if body.has_method("_get_hit"):
		print("yeah baby")
		body._get_hit()

func _on_action_end():
	if $AnimatedSprite.animation == "action":
		MAXSPEED = normalMax
		$AnimatedSprite.offset.x = 0
		$Fist.position.x = 0
		is_punching = false
	pass
	
func action():
	print ("lorem ipsum")
	normalMax = MAXSPEED
	MAXSPEED = 0
	$AnimatedSprite.animation = "action"
	if face_last == "right":
		$AnimatedSprite.offset.x = 33
		$Fist.position.x = 45
	else:
		$AnimatedSprite.offset.x = -33
		$Fist.position.x = -45
	is_punching = true
	pass

func get_pushed(push_vel):
	push_velocity = push_vel
	was_pushed = true

func _process(delta):
	if is_punching == false:
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
	velocity.y += GRAVITY*delta
	
	var friction
	
	if is_on_wall():
		velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):
		friction = 0
		velocity.x += ACCELERATION*delta
		if velocity.x > MAXSPEED:
			velocity.x = MAXSPEED
	elif Input.is_action_pressed("ui_left"):
		friction = 0
		velocity.x -= ACCELERATION*delta
		if velocity.x < -MAXSPEED:
			velocity.x = -MAXSPEED
	else:
		friction = 1
		#velocity.x = 0
	#print (prevy)
	if Input.is_action_just_pressed("ui_accept"):
			action()
	if is_on_floor():
		velocity.x += friction*-1*velocity.x
		velocity.y = 15
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMPSPEED
	if was_pushed == true:
		velocity = push_velocity
		was_pushed = false
			
	move_and_slide(velocity, UP)
	if velocity.x > 0:
		face_last = "right"
	elif velocity.x < 0:
		face_last = "left"
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y*2)

func reset():
	#print("bananas")
	emit_signal("morreu")

func hit_by_enemy(enemy):
	reset()
	
func fell():
	reset()
