extends TextureRect

func _ready():
	generate_voronoi_diagram(
	)
func generate_voronoi_diagram(imgSize : Vector2, num_cells: int):

	var img = Image.new()
	img.create(imgSize.x, imgSize.y, false, Image.FORMAT_RGBH)

	var points = []
	var colors = []

	for i in range(num_cells):
		points.push_back(Vector2(int(randf()*img.get_size().x), int(randf()*img.get_size().y)))

		randomize()
		var colorPossibilities = [ Color.blue, Color.red, Color.green, Color.purple, Color.yellow, Color.orange]
		colors.push_back(colorPossibilities[randi()%colorPossibilities.size()])

	for y in range(img.get_size().y):
		for x in range(img.get_size().x):
			var dmin = img.get_size().length()
			var j = -1
			for i in range(num_cells):
				var d = (points[i] - Vector2(x, y)).length()
				if d < dmin:
					dmin = d
					j = i
			img.lock()
			img.set_pixel(x, y, colors[j])
			img.unlock()


	var texture = ImageTexture.new()
	texture.create_from_image(img)
	self.set_texture(texture)
