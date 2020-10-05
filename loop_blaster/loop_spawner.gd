extends Node2D

signal wave_started(num)

var loops = []
var loop = preload("res://loop.tscn")
export(int) var segs

var col1 = null
var col2 = null

var speed = null

var easy_waves = [
	{
		"weak": 12,
		"pattern": [
			4, 0.8
		],
		"pause": 2.0
	},
	{
		"weak": 10,
		"pattern": [
			8, 1
		],
		"pause": 2.0
	},
]

var med_waves = [
	{
		"weak": 8,
		"pattern": [
			6, 0.7
		],
		"pause": 1.5
	},
	{
		"weak": 6,
		"pattern": [
			8, 0.6
		],
		"pause": 1.5
	},
]

var hard_waves = [
	{
		"weak": 2,
		"pattern": [
			10, 0.6
		],
		"pause": 1.0
	},
	{
		"weak": 4,
		"pattern": [
			12, 0.5
		],
		"pause": 1.0
	},
]

var waves = []
var current_wave = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func spawn(weak):
	var l = loop.instance()
	l.speed = speed
	l.set_cols(col1, col2)
	l.weak_segments = weak
	l.segments = segs
	add_child(l)
	l.connect("dead", self, "replace_loop")
	if loops.empty():
		$loop_collision.active_loop(l)
	loops.push_back(l)
	l.start()
	

func replace_loop(lp, shot):
	if shot: 
		get_parent().add_kill()
		$AudioStreamPlayer.pitch_scale = 1.0 + randf()/5 - 0.1
		$AudioStreamPlayer.play()
	else: 
		get_parent().damage_player()
	loops.remove(loops.find(lp))
	if loops.size() > 0:
		$loop_collision.active_loop(loops[0])
	
var counter = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_waves():
	if counter > 20:
		waves.push_back(hard_waves[randi()%len(hard_waves)])
	elif counter > 10:
		waves.push_back(med_waves[randi()%len(med_waves)])
	else:
		waves.push_back(easy_waves[randi()%len(easy_waves)])
	counter += 1
	print(counter)

func start_wave():
	if waves.empty(): load_waves()
	var w = waves.pop_front()
	for i in w["pattern"][0]:
		current_wave.append([w["weak"], w["pattern"][1]])
	current_wave.append(w["pause"])
	print(current_wave)

var first_loop:bool = true


func _on_Timer_timeout():
	if not current_wave.empty():
		var w = current_wave.pop_front()
		if w is Array:
			$Timer.wait_time = w[1]
			spawn(w[0])
			if first_loop: 

				first_loop = false
				if counter != 1:
					yield(get_tree().create_timer(speed),"timeout")
				emit_signal('wave_started', counter)
				
				
			if len(current_wave) <= 1:
				w = current_wave.pop_front()
				$Timer.wait_time = w
				start_wave()
				first_loop = true
