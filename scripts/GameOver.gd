extends CanvasLayer

@onready var score_label = $ScoreLabel  # Reference to the score label

func _ready():
	$RestartButton.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	score_label.text = "Final Score: " + str(Global.score)

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	Global.score = 0
