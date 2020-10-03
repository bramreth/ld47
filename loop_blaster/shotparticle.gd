extends Particles2D

var col:Color = Color.white
var dir:Vector2 = Vector2.ONE

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", Color.white, Color("00FFFFFF"), 2.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	process_material.color = col
	process_material.gravity = Vector3(dir.x * -50, dir.y * -50, 0)
	restart()
	yield(get_tree().create_timer(2),"timeout")
	queue_free()
