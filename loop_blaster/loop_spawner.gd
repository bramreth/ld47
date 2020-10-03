extends Node2D

var loops = []
var loop = preload("res://loop.tscn")
export(int) var segs

# Called when the node enters the scene tree for the first time.
func _ready():
	$loop_collision.set_segs(segs)
	if loops.empty():
		spawn()

func spawn():
	var l = loop.instance()
	l.segments = segs
	add_child(l)
	l.connect("dead", self, "replace_loop")
	loops.append(l)
	l.start()
	$loop_collision.active_loop(l)

func replace_loop(lp):
	print(lp)
	print("end!")
	loops.remove(loops.find(lp))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if loops.empty():
		spawn()
