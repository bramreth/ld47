extends Line2D

export(OpenSimplexNoise) var n
var origin
var time = 0
var roc = 8
var pulse_mag = 35
export(int) var distance = 75
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * roc
	for point in len(points):
		var pulse_rate = (distance/get_parent().max_width)
		var off = n.get_noise_2d(points[point].x+ time, points[point].y + time)*(pulse_rate)*pulse_mag
		points[point] = origin[point] * distance + Vector2(off, off)
		
		
		
func init():
	distance = get_parent().max_width
	origin = points
