extends Node2D

export(int) var life = 3
export(float) var rotation_speed = 0.1
export(float) var shoot_speed:float = 0.5
var can_shoot:bool = true
var shots = 1
var spread = 0

#var bullets:Array = [Color("ee5253"), Color("2e86de"), Color("f368e0")]
#var current_bullet_selection = 0

var weapons:Array = [
	{
		'shoot_speed': 0.5,
		'bullet': preload("res://bullet.tscn"),
		'shots': 1,
		'spread': 0
	},
	{
		'shoot_speed': 0.3,
		'bullet': preload("res://shottybullet.tscn"),
		'shots': 10,
		'spread': 0.4
	},
]
var current_weapon:int = 0

var bullet:PackedScene = preload("res://bullet.tscn")
var shot_particles:PackedScene = preload("res://shotparticle.tscn")

func _ready():
	$reload_visualiser.connect("reload_done", self, "reload_done")
	set_weapon()


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
		change_weapon()

func change_weapon():
	current_weapon = (current_weapon + 1) % weapons.size()
	set_weapon()


func set_weapon():
	bullet = weapons[current_weapon]['bullet']
	shoot_speed = weapons[current_weapon]['shoot_speed']
	shots = weapons[current_weapon]['shots']
	spread = weapons[current_weapon]['spread']
	
	for child in $bullet_indicator.get_children():
		child.queue_free()
	
	var b = bullet.instance()
	b.bullet_color = $Polygon2D/current_color.color
	$bullet_indicator.add_child(b)
	b.remove_collision()
	

func set_col(c):
	$Polygon2D/current_color.color = Color(c)

func reload_done():
	can_shoot = true

func shoot():
	if can_shoot:
		$AudioStreamPlayer.play()
		var s = shot_particles.instance()
		s.col = $Polygon2D/current_color.color
		s.dir = self.global_position.direction_to($Polygon2D.global_position).normalized()
		get_parent().add_child(s)
		s.global_position = $Polygon2D/bullet_spawn.global_position
		
		$AnimationPlayer.play("knockback")
		
		for i in range(shots):
			var b = bullet.instance()
			b.bullet_color = $Polygon2D/current_color.color
			get_parent().add_child(b)
			b.global_position = $Polygon2D/bullet_spawn.global_position
			print($Polygon2D/bullet_spawn.global_position)
			var shot_angle = global_position.angle_to_point($Polygon2D/bullet_spawn.global_position)
			print(shot_angle)
			shot_angle += rand_range(-spread, spread)
			var shot_direction = -Vector2(cos(shot_angle), sin(shot_angle)).normalized()
#			var shot_direction = self.global_position.direction_to($Polygon2D.global_position).normalized()
			b.shoot(shot_direction)
		
		$reload_visualiser.reload(shoot_speed)
		can_shoot = false
