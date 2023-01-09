extends KinematicBody2D

signal interact
signal go_down

# Declare member variables here. Examples:
var GRAVITY
const SAVON = 1.3
const JUMP = -210
const FALL_SPEED = 90
var speed = 50
var cooldown_dash = 0
var velocity = Vector2.ZERO

func start(pos,gravity):
	position=pos
	GRAVITY=gravity
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if(speed > 50) :
		speed = speed * 0.95
	if(speed < 50) :
		speed = 50
	
	if Input.is_action_just_pressed("ui_accept") :
		emit_signal("interact")
		
	if Input.is_action_just_pressed("ui_down") :
		emit_signal("go_down")
	
	if Input.is_action_just_pressed("ui_dash") && cooldown_dash == 0 :
		speed = speed * 4
		cooldown_dash = 1
		$DashCooldown.start(1)
	
	var pastVelocity = velocity
	velocity = Vector2.ZERO
	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if Input.is_action_just_pressed("ui_up") && is_on_floor() :
		velocity.y = JUMP
	else:
		velocity.y = GRAVITY
	
	if velocity.x != 0 :
		velocity.x*=speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = velocity.x > 0
	else :
		velocity.x=pastVelocity.x/SAVON
		if (velocity.x > -5 && velocity.x < 5):
			velocity.x = 0
			$AnimatedSprite.play("idle")
		
	if velocity.y != JUMP :
		if pastVelocity.y < 0 || !is_on_floor() :
			velocity.y = pastVelocity.y + GRAVITY
			if velocity.y > FALL_SPEED :
				velocity.y = FALL_SPEED
				
	move_and_slide(velocity,Vector2(0,-1))

func _on_DashCooldown_timeout():
	print("dash available")
	cooldown_dash = 0
