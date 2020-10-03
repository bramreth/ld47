extends Node2D


export(int) var width = 75
export(int) var segments = 62


# Called when the node enters the scene tree for the first time.
func _ready():
	create_loop()

func create_loop():
	print(range(segments))
	$Line2D.add_point(Vector2(cos(0), sin(0))*width)
	for seg in range(segments):
		var p = deg2rad((float(seg+1) / segments) * 360.0)
		$Line2D.add_point(Vector2(cos(p), sin(p))*width)
		print(p)
	$Line2D.init()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$CurveTween.start()
