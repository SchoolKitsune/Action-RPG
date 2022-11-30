extends KinematicBody2D

const ACCELERATION = 500 #ACCELERATION is the change in velocity over time
const MAX_SPEED = 100
const FRICTION = 500

enum{
	MOVE, 
	DASH,
	ATTACK
} #the contents of this enum are constants
# each of the constants are each given a number: move being 0, dash being 1 and attack being 2

var state = MOVE
var velocity = Vector2.ZERO #velocity is how much change of current position
#vector is the x and y position combined
onready var animationPlayer = $AnimationPlayer #$ is used to get access to a node in the scene tree
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true #func _ready(): #_ready runs when this node (Player) is ready inside of this scene.

func _physics_process(delta): #delta is how long the last frame took
	match state:
		MOVE: #if our state equals move then run the move_state function and so on for other states
			move_state(delta)
	
		DASH:
			pass
			
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO #up is 0,-1. right is 1,0. down is 0,1 and left is -1,0
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #normalized makes our character diagonal move speed the same as normal directions
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run") #travel gets access to the animationState so that i can set the right animation
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) #this makes it so that our velocity doesn't go faster than our MAX_SPEED
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #Speed moves slowly towards a vector of 0,0
 #if not pressing either
	velocity = move_and_slide(velocity) #this will make it so that the character will move in real time and if the game lags this will compensate for that
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_state(delta):
	velocity = 0
	animationState.travel("Attack")
	
func attack_animation_finished(): #by using call method at the end of my attack animations i can run a function once the animation ends
	state = MOVE
