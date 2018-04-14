extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0,-1)

export (int) var GRAVITY = 1000 # pixels/second²
export (int) var MAXSPEED = 300 # pixels/second

var velocity = Vector2(0,0)
var face_last = "left"

func _ready():
	velocity.x = MAXSPEED
	pass

func _process(delta):
	pass

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	
	
	
	if is_on_wall():
		velocity.x *= -1
	
	if is_on_floor():
		velocity.y = 15
			
	move_and_slide(velocity, UP)
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y*2)



func _on_damageDetect_body_entered(body):
	if body.has_method("hit_by_enemy"):
		body.hit_by_enemy(self)
