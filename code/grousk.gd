extends KinematicBody2D

var vel = Vector2()
export var max_speed = 150
const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACCEL = 5

var dirx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


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
	
	if is_on_wall():
		dirx *= -1
	
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
		

func play_anim(animation):
	if $anim.current_animation != animation:
		$anim.play(animation)

func _on_Timer_timeout():
	var m = rand_range(0, 10)
	if m < 5:
		dirx = -1
	elif m > 5:
		dirx = 1
	else :
		dirx = 0
