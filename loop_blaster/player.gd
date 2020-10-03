extends Node2D

export(int) var life = 3
export(float) var rotation_speed = 0.1
export(float) var shoot_speed:float = 1.0
var can_shoot:bool = true

func _ready():
	$reload_visualiser.connect("reload_done", self, "reload_done")


func _physics_process(delta):
	if inputmanager.control_preference == inputmanager.CONTROL_TYPE.MOUSE:
		look_at(get_global_mouse_position())
	if inputmanager.control_preference == inputmanager.CONTROL_TYPE.KEYBOARD:
		if Input.is_action_pressed("left"): rotate(-rotation_speed)
		if Input.is_action_pressed("right"): rotate(rotation_speed)


func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()


func reload_done():
	can_shoot = true

func shoot():
	if can_shoot:
		$reload_visualiser.reload(shoot_speed)
		can_shoot = false
