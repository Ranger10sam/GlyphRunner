extends Area2D

# Wall types
enum WallType { PHASE, VOID }
enum ShapeType { CIRCLE, SQUARE, TRIANGLE }

# Exported variables for configuration
@export var wall_type: WallType = WallType.PHASE
@export var shape_type: ShapeType = ShapeType.CIRCLE

# Movement speed (pixels per second)
var speed: float = 300.0

# Wall textures for different types and shapes
var wall_textures: Dictionary = {}

# References to child nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	# Load wall textures
	load_wall_textures()
	# Set initial appearance
	update_wall_display()
	
	# Connect the body_entered signal if not already connected
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _process(delta):
	# Move wall from right to left
	position.x -= speed * delta
	
	# Remove wall when it goes off-screen (left side)
	if position.x < -200:
		queue_free()

func load_wall_textures():
	# Create placeholder textures for different wall types and shapes
	for wall_t in WallType.values():
		wall_textures[wall_t] = {}
		for shape_t in ShapeType.values():
			wall_textures[wall_t][shape_t] = create_wall_texture(wall_t, shape_t)

func create_wall_texture(wall_t: WallType, shape_t: ShapeType) -> Texture2D:
	var image = Image.create(200, 400, false, Image.FORMAT_RGBA8)
	
	# Base wall color
	var wall_color = Color.RED if wall_t == WallType.VOID else Color.BLUE
	image.fill(wall_color)
	
	# Create cutout/highlight for the shape
	var center_x = 100
	var center_y = 200
	var cutout_color = Color.TRANSPARENT if wall_t == WallType.VOID else Color.WHITE
	
	match shape_t:
		ShapeType.CIRCLE:
			for x in range(200):
				for y in range(400):
					var distance = Vector2(x - center_x, y - center_y).length()
					if distance <= 40:
						image.set_pixel(x, y, cutout_color)
		ShapeType.SQUARE:
			for x in range(center_x - 40, center_x + 40):
				for y in range(center_y - 40, center_y + 40):
					if x >= 0 and x < 200 and y >= 0 and y < 400:
						image.set_pixel(x, y, cutout_color)
		ShapeType.TRIANGLE:
			for x in range(200):
				for y in range(center_y - 40, center_y + 40):
					if y >= 0 and y < 400:
						var triangle_width = (center_y + 40 - y) * 2
						var triangle_start = center_x - triangle_width / 2
						var triangle_end = center_x + triangle_width / 2
						if x >= triangle_start and x <= triangle_end:
							image.set_pixel(x, y, cutout_color)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	return texture

func update_wall_display():
	# Update sprite texture based on wall type and shape
	if sprite and wall_textures.has(wall_type) and wall_textures[wall_type].has(shape_type):
		sprite.texture = wall_textures[wall_type][shape_type]

func set_wall_properties(new_wall_type: WallType, new_shape_type: ShapeType):
	wall_type = new_wall_type
	shape_type = new_shape_type
	if is_inside_tree():
		update_wall_display()

func _on_body_entered(body):
	# Check if the entering body is the player
	if body.name == "Player":
		check_collision_with_player(body)

func check_collision_with_player(player):
	# Get player's current shape
	var player_shape = player.get_current_shape()
	
	print("Wall collision detected!")
	print("Wall type: ", get_wall_type_name())
	print("Wall shape: ", get_shape_name())
	print("Player shape: ", player.get_shape_name())
	
	# Game over logic
	var game_over = false
	
	match wall_type:
		WallType.PHASE:
			# Phase walls: player must match the shape to pass through
			if player_shape != shape_type:
				game_over = true
				print("GAME OVER: Player shape doesn't match phase wall!")
		WallType.VOID:
			# Void walls: player must NOT match the shape to pass through
			if player_shape == shape_type:
				game_over = true
				print("GAME OVER: Player shape matches void wall!")
	
	if game_over:
		print("GAME OVER")
		player.queue_free()
	else:
		print("Safe passage!")

func get_wall_type_name() -> String:
	match wall_type:
		WallType.PHASE:
			return "Phase"
		WallType.VOID:
			return "Void"
		_:
			return "Unknown"

func get_shape_name() -> String:
	match shape_type:
		ShapeType.CIRCLE:
			return "Circle"
		ShapeType.SQUARE:
			return "Square"
		ShapeType.TRIANGLE:
			return "Triangle"
		_:
			return "Unknown" 