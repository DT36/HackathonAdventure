extends CharacterBody2D

const GRAVITY = 500
const JUMP_FORCE = -480
const SPEED = 200

var vel = Vector2.ZERO

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $Sprite2D

func _physics_process(delta):
	vel.y += GRAVITY * delta

	if Input.is_action_pressed("ui_right"):
		vel.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		vel.x = -SPEED
	else:
		vel.x = 0

	if is_on_floor() and Input.is_action_just_pressed("ui_select"):
		vel.y = JUMP_FORCE
		
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	velocity = vel

	move_and_slide()

func _ready():
	pass

func game_over():
	print("Game over called")  # Debug line to ensure this method is called
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
