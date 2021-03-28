extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	camera_set_limit() # Replace with function body.

func camera_set_limit():
	var zone = $Autotile.get_used_rect()
	var cells_size = $Autotile.cell_size
	
	$player/cam.limit_top = zone.position.y * cells_size.y
	$player/cam.limit_left = zone.position.x * cells_size.x
	$player/cam.limit_right = (zone.size.x + zone.position.x) * cells_size.x
	$player/cam.limit_bottom = (zone.size.y + zone.position.y) * cells_size.y
