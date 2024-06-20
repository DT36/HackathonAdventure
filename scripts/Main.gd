extends Node2D

const COLLECTIBLE_SCENES = [
	preload("res://scenes/Collectible1.tscn"),
	preload("res://scenes/Collectible2.tscn"),
	preload("res://scenes/Collectible3.tscn")
]

const OBSTACLE_SCENES = [
	preload("res://scenes/Obstacle1.tscn"),
	preload("res://scenes/Obstacle2.tscn")
]

const FLOOR_Y_POSITION = 600  # Adjust floor Y position as needed
const MIN_DISTANCE_BETWEEN_ITEMS = 150  # Adjust minimum distance as needed
const MAX_ACTIVE_ITEMS = 10  # Adjust maximum active items as needed

var last_spawn_position = Vector2.ZERO

@onready var score_label = $ScoreLabel  # Reference to the score label

func _ready():
	_spawn_collectibles()
	_spawn_obstacles()
	update_score(0)  # Initialize score display

func _spawn_collectibles() -> void:
	while true:
		if get_active_collectibles_count() < MAX_ACTIVE_ITEMS:
			var random_index = randi() % COLLECTIBLE_SCENES.size()
			var collectible_scene = COLLECTIBLE_SCENES[random_index]
			var collectible_instance = collectible_scene.instantiate()
			var spawn_position = Vector2(get_viewport().size.x + 100, randf_range(100, FLOOR_Y_POSITION - 100))

			while last_spawn_position.distance_to(spawn_position) < MIN_DISTANCE_BETWEEN_ITEMS:
				spawn_position = Vector2(get_viewport().size.x + 100, randf_range(100, FLOOR_Y_POSITION - 100))

			collectible_instance.position = spawn_position
			last_spawn_position = spawn_position
			add_child(collectible_instance)
		await get_tree().create_timer(2.0).timeout  # Adjust spawn rate as needed

func _spawn_obstacles() -> void:
	while true:
		if get_active_obstacles_count() < MAX_ACTIVE_ITEMS:
			var random_index = randi() % OBSTACLE_SCENES.size()
			var obstacle_scene = OBSTACLE_SCENES[random_index]
			var obstacle_instance = obstacle_scene.instantiate()
			var spawn_position = Vector2(get_viewport().size.x + 100, randf_range(100, FLOOR_Y_POSITION - 100))

			while last_spawn_position.distance_to(spawn_position) < MIN_DISTANCE_BETWEEN_ITEMS:
				spawn_position = Vector2(get_viewport().size.x + 100, randf_range(100, FLOOR_Y_POSITION - 100))

			obstacle_instance.position = spawn_position
			last_spawn_position = spawn_position
			add_child(obstacle_instance)
		await get_tree().create_timer(3.0).timeout  # Adjust spawn rate as needed

func get_active_collectibles_count() -> int:
	var count = 0
	for child in get_children():
		if child.is_in_group("Collectible"):  # Check if the child is in the Collectible group
			count += 1
	return count

func get_active_obstacles_count() -> int:
	var count = 0
	for child in get_children():
		if child.is_in_group("Obstacle"):  # Check if the child is in the Obstacle group
			count += 1
	return count

func update_score(points: int):
	Global.score += points
	score_label.text = "Score: " + str(Global.score)
