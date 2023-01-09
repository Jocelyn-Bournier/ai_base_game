extends KinematicBody2D

signal interact
signal go_down

# Declare member variables here. Examples:
var GRAVITY
const SAVON = 1.3
const JUMP = -210
const FALL_SPEED = 90
const DASH_SPEED = 200
const BASE_SPEED = 50
var speed = BASE_SPEED
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
#delta is handled automaticaly by move_and_slide
func _physics_process(_delta):
	
	if(speed > BASE_SPEED) :
		speed = speed * 0.95
		if(speed > 1.5*BASE_SPEED):
			$AnimatedSprite.play("dash")
	if(speed <= BASE_SPEED) :
		speed = BASE_SPEED
	
	if Input.is_action_just_pressed("ui_accept") :
		emit_signal("interact")
		
	if Input.is_action_just_pressed("ui_down") :
		emit_signal("go_down")
	
	if Input.is_action_just_pressed("ui_dash") && cooldown_dash == 0 :
		speed = DASH_SPEED
		cooldown_dash = 1
		$AnimatedSprite.play("dash")
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
				
	var _returnedVector = move_and_slide(velocity,Vector2(0,-1))

func _on_DashCooldown_timeout():
	print("dash available")
	cooldown_dash = 0
