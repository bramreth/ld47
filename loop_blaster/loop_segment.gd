extends Area2D

export(bool) var weak = false
var loop_ref = null

func get_weak():
	return weak

func update_shape(v1, v2):
	$CollisionShape2D.shape.a = v1
	$CollisionShape2D.shape.b = v2


func _on_Area2D_area_entered(area):
	if not area.name.match("*seg*"):
		print(area.name)


func _on_seg_area_shape_entered(area_id, area, area_shape, self_shape):
	if not area.name.match("*seg*"):
		print(area.name)


func _on_seg_body_entered(body):
	print(body)
