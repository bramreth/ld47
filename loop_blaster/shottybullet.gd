extends "res://bullet.gd"


func _ready():
	speed += rand_range(-0.3,0.3)


func _physics_process(delta):
	speed -= 0.2
	if speed > 0:
		._physics_process(delta)
	else: queue_free()
