extends KinematicBody2D
var endScore: int = 0
var speed : int = 300
var jumpForce : int = 700
var gravity : int = 1000
onready var anim = get_node("AnimatedSprite")
var jump_count = 0
var screen_size
var score: float = 0
onready var ui : Node = get_node("/root/MainScene/UI")
var vel : Vector2 = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	vel.x = 0
	#inputs
	if PlayerData.score > 5.00:
		speed = 200
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	manage_animations()
	scoreCalc()
	flipsprite()
	
	
	#applying velocity
	vel = move_and_slide(vel, Vector2.UP)
	
	
	#gravity
	vel.y += delta*gravity*2
	
	#jump input
	if Input.is_action_just_pressed("fly") and is_on_floor():
		$Buzz.play()
		vel.y =-jumpForce
		jump_count=1

	
	if jump_count<2:
		if Input.is_action_just_pressed("fly") and not is_on_floor():
			$Buzz.play()
			vel.y =-jumpForce
			jump_count +=1
			
	#if is_on_floor():
	#	$Buzz.stop()


	
func manage_animations():
	if PlayerData.score < 5.00 and Input.is_action_pressed("fly") and !is_on_floor():
		play_animations("flying")
	elif PlayerData.score < 5.00 and vel.x==0 and is_on_floor():
		play_animations("idle")
	elif PlayerData.score > 5.00 and Input.is_action_pressed("fly") and !is_on_floor():
		play_animations("flying_blood")
	elif vel.x==0 and is_on_floor() and PlayerData.score >5.00:
		play_animations("idle_blood")
	elif PlayerData.score < 5.00 and vel.x!=0 and is_on_floor():
		play_animations("walk")
	elif PlayerData.score > 5.00 and vel.x!=0 and is_on_floor():
		play_animations("fatwalk")


func play_animations(anim_name):
	if anim.animation !=anim_name:
		anim.play(anim_name)

func die():
	PlayerData.deaths +=1
	get_tree().change_scene("res://End_Screen.tscn")
	

func scoreCalc():
	if vel.x==0 and !Input.is_action_just_pressed("fly"):
		yield(get_tree().create_timer(1), "timeout")
		if vel.x ==0 and !Input.is_action_pressed("fly"):
			score= score+0.01
		
	ui.set_score(score)
	PlayerData.score = score
	
func flipsprite():
	if vel.x < 0:
		$AnimatedSprite.flip_h = true
	elif vel.x >0:
		$AnimatedSprite.flip_h = false


