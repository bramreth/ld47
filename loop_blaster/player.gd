extends Node2D

export(int) var life = 3
export(float) var rotation_speed = 0.1
export(float) var shoot_speed:float = 0.5
var can_shoot:bool = true

var bullets:Array = [Color("ee5253"), Color("2e86de"), Color("f368e0")]
var current_bullet_selection = 0

var bullet:PackedScene = preload("res://bullet.tscn")

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
	if event.is_action_pressed("swap_bullet"):
		current_bullet_selection = (current_bullet_selection + 1) % bullets.size()
		$Polygon2D/current_color.color = bullets[current_bullet_selection]


func reload_done():
	can_shoot = true

func shoot():
	if can_shoot:
		var b = bullet.instance()
		b.bullet_color = bullets[current_bullet_selection]
		get_parent().add_child(b)
		b.global_position = $Polygon2D/bullet_spawn.global_position
		b.shoot(self.global_position.direction_to($Polygon2D.global_position).normalized())
		$reload_visualiser.reload(shoot_speed)
		can_shoot = false
