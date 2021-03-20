extends KinematicBody2D

var vel = Vector2()
var max_speed = 200
const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACCEL = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# execute 60 tick par seconde
func _physics_process(delta):
	#vel.x = 0
	mouvement_loop()
	vel.y += GRAVITY * delta
	
	
	vel = move_and_slide(vel, UP)

func mouvement_loop():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var dirx = int(right) - int(left)
	
	if dirx == -1 : # gauche
		vel.x = max(vel.x - ACCEL, -max_speed)
		$Sprite.flip_h = true
		play_anim("walk")
	elif dirx == 1 : # droite
		vel.x = min(vel.x + ACCEL, max_speed)
		$Sprite.flip_h = false
		play_anim("walk")
	else:
		vel.x = lerp(vel.x, 0, 0.15)
		play_anim("idle")
		
	if jump == true and is_on_floor():
		vel.y = -700
		
	if vel.y < 0:
		play_anim("jump up")
	if vel.y > 0:
		play_anim("jump_down")

func play_anim(animation):
	if $anim.current_animation != animation:
		$anim.play(animation)
