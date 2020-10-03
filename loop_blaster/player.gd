extends Node2D

export(int) var life = 3
export(float) var rotation_speed = 0.1

func _ready():
	pass


func _physics_process(delta):
	if inputmanager.control_preference == inputmanager.CONTROL_TYPE.MOUSE:
		look_at(get_global_mouse_position())
	if inputmanager.control_preference == inputmanager.CONTROL_TYPE.KEYBOARD:
		if Input.is_action_pressed("left"): rotate(-rotation_speed)
		if Input.is_action_pressed("right"): rotate(rotation_speed)


func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()


func shoot():
	print("pew")
