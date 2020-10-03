extends Node2D

var loops = []
var loop = preload("res://loop.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if loops.empty():
		spawn()

func spawn():
	var l = loop.instance()
	add_child(l)
	l.connect("dead", self, "replace_loop")
	loops.append(l)
	l.start()

func replace_loop(lp):
	print(lp)
	print("end!")
	loops.remove(loops.find(lp))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if loops.empty():
		spawn()
