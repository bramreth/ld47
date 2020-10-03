extends Node2D


export(float) var speed = 2.0
export(Color) var bullet_color = Color("ee5253")
export(float) var size = 5.0
export(int) var detail = 32

var direction:Vector2 = Vector2.ZERO


func _ready():
	set_physics_process(false)
	var rad = 0
	var points:PoolVector2Array = []
	for i in range(detail):
		rad += 2 * PI / detail
		points.append(Vector2(size * sin(rad), size * cos(rad)))
	$Polygon2D.polygon = points
	$Polygon2D.color = bullet_color
	$collision/collisionshape.shape.radius = size
	
	shoot(Vector2(1,1))

func shoot(direction:Vector2):
	self.direction = direction
	set_physics_process(true)

func _physics_process(delta):
	global_position += direction * speed

func _on_collision_area_entered(area:Area2D):
	print("boom")
	if not area.loop_ref: return
	if area.get_weak():
		print("BANG", area.loop_ref)
		
		area.loop_ref.die(true)
		pass #COLOOSION GOES HERE, if you compare bullet_color to the line segment color you can check for hte right match as well
	self.queue_free()
