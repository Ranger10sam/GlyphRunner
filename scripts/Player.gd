extends CharacterBody2D

# Shape constants
enum ShapeType { CIRCLE, SQUARE, TRIANGLE }

# Current shape (0=circle, 1=square, 2=triangle)
var current_shape: int = ShapeType.CIRCLE

# Shape textures
var shape_textures: Array[Texture2D] = []

# References to child nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	# Load placeholder shape textures
	load_shape_textures()
	# Set initial shape
	update_shape_display()

func _input(event):
	# Check for shape cycling input
	if event.is_action_pressed("ui_accept"):
		cycle_shape()

func load_shape_textures():
	# Load the three shape textures
	# For now, we'll create placeholder textures programmatically
	shape_textures.resize(3)
	
	# Create circle texture
	var circle_image = Image.create(128, 128, false, Image.FORMAT_RGBA8)
	circle_image.fill(Color.TRANSPARENT)
	for x in range(128):
		for y in range(128):
			var distance = Vector2(x - 64, y - 64).length()
			if distance <= 32:
				circle_image.set_pixel(x, y, Color.GREEN)
	var circle_texture = ImageTexture.new()
	circle_texture.set_image(circle_image)
	shape_textures[ShapeType.CIRCLE] = circle_texture
	
	# Create square texture
	var square_image = Image.create(128, 128, false, Image.FORMAT_RGBA8)
	square_image.fill(Color.TRANSPARENT)
	for x in range(32, 96):
		for y in range(32, 96):
			square_image.set_pixel(x, y, Color.GREEN)
	var square_texture = ImageTexture.new()
	square_texture.set_image(square_image)
	shape_textures[ShapeType.SQUARE] = square_texture
	
	# Create triangle texture
	var triangle_image = Image.create(128, 128, false, Image.FORMAT_RGBA8)
	triangle_image.fill(Color.TRANSPARENT)
	for x in range(128):
		for y in range(32, 96):
			# Simple triangle shape
			var triangle_width = (96 - y) * 2
			var triangle_start = 64 - triangle_width / 2
			var triangle_end = 64 + triangle_width / 2
			if x >= triangle_start and x <= triangle_end:
				triangle_image.set_pixel(x, y, Color.GREEN)
	var triangle_texture = ImageTexture.new()
	triangle_texture.set_image(triangle_image)
	shape_textures[ShapeType.TRIANGLE] = triangle_texture

func cycle_shape():
	# Cycle through shapes: 0->1, 1->2, 2->0
	current_shape = (current_shape + 1) % 3
	update_shape_display()
	print("Player shape changed to: ", get_shape_name())

func update_shape_display():
	# Update the sprite texture based on current shape
	if sprite and shape_textures.size() > current_shape:
		sprite.texture = shape_textures[current_shape]
	
	# Update collision shape based on current shape
	update_collision_shape()

func update_collision_shape():
	# Update collision shape to match the visual shape
	var new_shape: Shape2D
	
	match current_shape:
		ShapeType.CIRCLE:
			var circle_shape = CircleShape2D.new()
			circle_shape.radius = 32
			new_shape = circle_shape
		ShapeType.SQUARE:
			var rect_shape = RectangleShape2D.new()
			rect_shape.size = Vector2(64, 64)
			new_shape = rect_shape
		ShapeType.TRIANGLE:
			# For triangle, we'll use a simplified rectangular collision for now
			var rect_shape = RectangleShape2D.new()
			rect_shape.size = Vector2(64, 64)
			new_shape = rect_shape
	
	collision_shape.shape = new_shape

func get_shape_name() -> String:
	match current_shape:
		ShapeType.CIRCLE:
			return "Circle"
		ShapeType.SQUARE:
			return "Square"
		ShapeType.TRIANGLE:
			return "Triangle"
		_:
			return "Unknown"

func get_current_shape() -> int:
	return current_shape 