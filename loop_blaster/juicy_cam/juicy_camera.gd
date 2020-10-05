extends Camera2D

export (OpenSimplexNoise) var noise
export(float, 0, 1) var trauma = 0.0

export var max_x = 75
export var max_y = 75
export var max_r = 15

export var time_scale = 150

export(float, 0, 1) var decay = 0.6

var time = 0

var target = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_trauma(trauma_in):
	trauma = clamp(trauma + trauma_in, 0, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	var shake = trauma # pow(trauma, 2)
	offset.x = noise.get_noise_3d(time * time_scale, 0, 0) * max_x * shake
	offset.y = noise.get_noise_3d(0, time * time_scale, 0) * max_y * shake
	rotation_degrees = noise.get_noise_3d(0, 0, time * time_scale) * max_r * shake
	
	if trauma > 0: trauma = clamp(trauma - (delta * decay), 0, 1)
#	position = lerp(position, target.position, delta * 10)
#	zoom = lerp(zoom, target.zoom, delta * 10)

func _input(event):
	if Input.get_action_strength("ui_end"):
		add_trauma(0.2)
