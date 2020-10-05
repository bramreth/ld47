extends Area2D


var segments = 12
export var max_width = 75

export(String) var option_type = "Loop"
var upgrade_type:String = 'bullet'

var levels = {
	"Loop": ["lv1", "ff9ff3"],
	"Moebius": ["lv2", "48dbfb"],
	"Ouroboros": ["lv3", "ff6b6b"],
	"Upgrade Bullet": ["shop", "ffffff"],
	"Upgrade Reload": ["shop", "ffffff"],
	"Automatic": ["shop", "ffffff"]
}

func update_record():
	match levels[option_type][0]:
		"lv1":
			$Control/VBoxContainer/rec.text = str(Manager.l1_record)
			$Label.text = str(Manager.creds_obj[levels[option_type][0]]) + "/10"
			if Manager.creds_obj[levels[option_type][0]] >= 10:
				$Sprite.visible = true
		"lv2":
			$Control/VBoxContainer/rec.text = str(Manager.l2_record)
			$Label.text = str(Manager.creds_obj[levels[option_type][0]]) + "/10"
			if Manager.creds_obj[levels[option_type][0]] >= 10:
				$Sprite.visible = true
		"lv3":
			$Control/VBoxContainer/rec.text = str(Manager.l3_record)
			$Label.text = str(Manager.creds_obj[levels[option_type][0]]) + "/10"
			if Manager.creds_obj[levels[option_type][0]] >= 10:
				$Sprite.visible = true
		"shop":
			if option_type == "Automatic": 
				$Control/VBoxContainer/rec.text = String(Manager.auto)
			if option_type == "Upgrade Bullet": 
				$Control/VBoxContainer/rec.text = String(Manager.s)
			if option_type == "Upgrade Reload": 
				$Control/VBoxContainer/rec.text = String(Manager.r)	
	$Label.visible = not ($Label.text == "x/10")
#	$Control/VBoxContainer/rec.text = str(level)

func invis():
	$Polygon2D.visible = false
	$Line2D.visible = false
	$Control/VBoxContainer.visible = false
	$Label.visible = false

func die():
	$AnimationPlayer.play("pop")

func die_but_not_really():
	$AnimationPlayer.play("pop2")

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(option_type in levels.keys(), "invald option type")
	randomize()
	create_loop()
	$Line2D.default_color = col_blast(levels[option_type][1])
	var option_name:String = option_type
	if option_name == "Upgrade Bullet": 
		option_name = "Upgrade\nBullet"
		upgrade_type = "bullet"
	if option_name == "Upgrade Reload": 
		option_name ="Upgrade\nReload"
		upgrade_type = 'reload'
	if option_name == "Automatic": 
		option_name ="Automatic"
		upgrade_type = 'auto'

	$Control/VBoxContainer/Label.text = option_name
	$Line2D.init(12)
	$Line2D.n.seed = randi()
	update_record()
	
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


func update_rec(num):
	print(num)
	$Control/VBoxContainer/rec.text = String(num)
