extends KinematicBody2D

const MAX_SPEED = 200
const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACCEL = 5

var vel = Vector2()
var jump_count = 0
var bullet_dir = 1
var bullet = preload("res://scene/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# execute 60 tick par seconde
func _physics_process(delta):
	mouvement_loop()
	animation_loop()
	vel.y += GRAVITY * delta
	
	vel = move_and_slide(vel, UP)

func mouvement_loop():
	if is_on_floor():
		jump_count = 0
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	var shoot = Input.is_action_just_pressed("ui_accept")
	
	var dirx = int(right) - int(left)
	
	if dirx == -1 : # gauche
		vel.x = max(vel.x - ACCEL, -MAX_SPEED)
		bullet_dir = -1
		$muzzle.position.x = -20
		$Sprite.flip_h = true
	elif dirx == 1 : # droite
		vel.x = min(vel.x + ACCEL, MAX_SPEED)
		bullet_dir = 1
		$Sprite.flip_h = false
		$muzzle.position.x = 10
	else:
		vel.x = lerp(vel.x, 0, 0.3)
		
	if jump == true and jump_count < 2:
		vel.y = -600
		jump_count += 1
		
	if shoot:
		play_anim("shoot")
		var b = bullet.instance()
		b.start($muzzle.global_position, bullet_dir)
		get_parent().add_child(b)

func animation_loop():
	if vel.x > 0.001 or vel.x < -0.001:
		#print(vel.x)
		play_anim("walk")
	else:
		#print("Passage en idle")
		play_anim("idle")
		
	if vel.y < 0:
		play_anim("jump up")
	elif vel.y > 0:
		play_anim("jump_down")
		
	if vel.y != 0:
		$cam.zoom.x = lerp($cam.zoom.x, 1.2, 0.015)
		$cam.zoom.y = lerp($cam.zoom.y, 1.2, 0.015)
	else:
		$cam.zoom.x = lerp($cam.zoom.x, 0.8, 0.015)
		$cam.zoom.y = lerp($cam.zoom.y, 0.8, 0.015)

func play_anim(animation):
	if $anim.current_animation != animation:
		$anim.play(animation)
