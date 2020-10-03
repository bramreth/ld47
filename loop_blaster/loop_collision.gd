extends Node2D

var segs = 8
var segment = preload("res://loop_segment.tscn")
var seg_list = []
var active = null

func set_segs(segs_in):
	segs = segs_in
	setup_seglist()
	
func setup_seglist():
	seg_list = []
	for n in segs:
		var s = segment.instance()
		add_child(s)
		seg_list.append(s)
		
func update_collision():
	if active:
		var update_dat = active.get_segs()
		var counter = 0
		for k in update_dat.keys():
			
			seg_list[counter].update_shape(k[0], k[1])
			seg_list[counter].weak = update_dat[k]
			
		
		
		
func _process(delta):
	update_collision()
	

func active_loop(l):
	active = l
