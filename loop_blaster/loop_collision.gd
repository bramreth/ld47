extends Node2D

var segs = 8
var segment = preload("res://loop_segment.tscn")
var seg_list = []
var seg_list_2 = []
var active = null
var list_a = true

func set_segs(segs_in):
	segs = segs_in
	setup_seglist()
	
func setup_seglist():
	seg_list = []
	seg_list_2 = []
	for n in segs:
		var s = segment.instance()
		add_child(s)
		seg_list.append(s)
		
	for n in segs:
		var s = segment.instance()
		add_child(s)
		seg_list_2.append(s)
	init_collision()

		
func update_collision():
	if active:
		var ls = seg_list if list_a else seg_list_2
		list_a = not list_a
		var update_dat = active.get_segs()
		var counter = 0
		for k in update_dat.keys():
			
			ls[counter].update_shape(k[0], k[1])
			ls[counter].weak = update_dat[k]
			counter += 1
			
func init_collision():
	if active:
		var update_dat = active.get_segs()
		var counter = 0
		for k in update_dat.keys():
			seg_list[counter].loop_ref = active
			seg_list[counter].update_shape(k[0], k[1])
			seg_list[counter].weak = update_dat[k]
			counter += 1
		counter = 0
		for k in update_dat.keys():
			seg_list_2[counter].loop_ref = active
			seg_list_2[counter].update_shape(k[0], k[1])
			seg_list_2[counter].weak = update_dat[k]
			counter += 1
		
			
		
func _process(delta):
	update_collision()
	

func active_loop(l):
	active = l
	init_collision()
