extends Line2D

export(OpenSimplexNoise) var n
var origin
var time = 0
var roc = 16
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * roc
	for point in len(points):
		var off = n.get_noise_2d(points[point].x+ time, points[point].y + time)*25
		points[point] = origin[point] + Vector2(off, off)
		
		
		
func init():
	origin = points
