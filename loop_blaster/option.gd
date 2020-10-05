extends Area2D


var segments = 12
export var max_width = 75

export(String) var option_type = "Loop"

var levels = {
	"Loop": ["lv1", "ff9ff3"],
	"Moebius": ["lv2", "48dbfb"],
	"Ouroboros": ["lv3", "ff6b6b"],
	"Shop": ["shop", "feca57"]
}

func invis():
	$Polygon2D.visible = false
	$Line2D.visible = false
	$Control/Label.visible = false

func die():
	$AnimationPlayer.play("pop")

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(option_type in levels.keys(), "invalid option type")
	randomize()
	create_loop()
	$Line2D.default_color = col_blast(levels[option_type][1])
	$Control/Label.text = option_type
	$Line2D.init(12)
	$Line2D.n.seed = randi()
	
func col_blast(col):
	var c = Color(col)
	if c.r > 0.9:
		c.r *= 2
	if c.g > 0.9:
		c.g *= 2
	if c.b > 0.9:
		c.b *= 2
	return c
	
func create_loop():
	$Line2D.add_point(Vector2(cos(0), sin(0)))
	for seg in range(segments):
		var p = deg2rad((float(seg+1) / segments) * 360.0)
		$Line2D.add_point(Vector2(cos(p), sin(p)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Polygon2D.polygon = $Line2D.points
