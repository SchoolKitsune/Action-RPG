extends KinematicBody2D

const ACCELERATION = 500 #ACCELERATION is the change in velocity over time
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO #velocity is how much change of current position
#vector is the x and y position combined
onready var animationPlayer = $AnimationPlayer #$ is used to get access to a node in the scene tree

func _physics_process(delta): #delta is how long the last frame took
	var input_vector = Vector2.ZERO #up is 0,-1. right is 1,0. down is 0,1 and left is -1,0
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #normalized makes our character diagonal move speed the same as normal directions
	
	if input_vector != Vector2.ZERO:
		if input_vector. x > 0:
			animationPlayer.play("RunRight")
		else:
			animationPlayer.play("RunRight")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) #this makes it so that our velocity doesn't go faster than our MAX_SPEED
	else:
		animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #Speed moves slowly towards a vector of 0,0
		
 #if not pressing either
	velocity = move_and_slide(velocity) #this will make it so that the character will move in real time and if the game lags this will compensate for that
	
#func _ready(): #_ready runs when this node (Player) is ready inside of this scene.
