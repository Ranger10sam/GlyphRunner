extends Node2D

# Preload the Wall scene
const WallScene = preload("res://scenes/Wall.tscn")

# Wall spawn settings
var spawn_position_x: float = 1200.0  # Off-screen to the right
var spawn_position_y: float = 960.0   # Center of screen vertically

# References to child nodes
@onready var player = $Player
@onready var wall_spawn_timer = $WallSpawnTimer
@onready var camera = $Camera2D

# Game state
var score: int = 0
var game_active: bool = true

func _ready():
	print("GlyphRunner Game Started!")
	print("Press SPACE, ENTER, or click to cycle player shape")
	print("Match your shape to PHASE walls (blue) to pass through")
	print("Avoid matching VOID walls (red) or you'll be destroyed!")
	
	# Connect the timer signal if not already connected
	if not wall_spawn_timer.timeout.is_connected(_on_wall_spawn_timer_timeout):
		wall_spawn_timer.timeout.connect(_on_wall_spawn_timer_timeout)

func _process(_delta):
	# Check if player still exists (game over check)
	if not is_instance_valid(player):
		if game_active:
			game_over()

func spawn_wall():
	if not game_active:
		return
		
	# Create a new wall instance
	var wall = WallScene.instantiate()
	
	# Set random wall properties
	var wall_type = randi() % 2  # 0 = PHASE, 1 = VOID
	var shape_type = randi() % 3  # 0 = CIRCLE, 1 = SQUARE, 2 = TRIANGLE
	
	# Set wall properties using the enum values
	wall.set_wall_properties(wall_type, shape_type)
	
	# Position the wall off-screen to the right
	wall.position = Vector2(spawn_position_x, spawn_position_y)
	
	# Add the wall to the scene
	add_child(wall)
	
	print("Spawned ", wall.get_wall_type_name(), " wall with ", wall.get_shape_name(), " shape")

func _on_wall_spawn_timer_timeout():
	spawn_wall()

func game_over():
	game_active = false
	wall_spawn_timer.stop()
	print("=== GAME OVER ===")
	print("Final Score: ", score)
	print("Press F5 to restart the game")

func increase_score():
	score += 1
	print("Score: ", score)

# Input handling for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):  # ESC key
		print("Game paused/quit")
		get_tree().quit() 