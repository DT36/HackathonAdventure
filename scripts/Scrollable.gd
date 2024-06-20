extends Area2D

const SPEED = 100

func _process(delta):
	position.x -= SPEED * delta
	
	if position.x < -get_viewport().size.x:
		queue_free()

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	print("Collision detected with:", body.name)  # Debug line
	if body.is_in_group("Player"):
		if is_in_group("Obstacle"):  # Check if the current node is an obstacle
			print("Collided with Player and it's an Obstacle")  # Debug line
			body.game_over()  # Call the game_over method on the player
		elif is_in_group("Collectible"):  # Check if the current node is a collectible
			print("Collided with Player and it's a Collectible")  # Debug line
			get_tree().root.get_node("Main").update_score(1)  # Increment the score by 1
		queue_free()
