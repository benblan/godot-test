extends KinematicBody2D

var speed = 1000
var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(vel * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(20)
		queue_free()

func start(pos, dir):
	position = pos
	vel = Vector2(speed * dir, 0)
