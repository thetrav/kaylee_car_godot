extends Node

@export var car_scene: PackedScene
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_timer_timeout():
	score += 1

func _on_player_hit() -> void:
	$ScoreTimer.stop()
	$TrafficTimer.stop()

func _on_traffic_timer_timeout():
	# Create a new instance of the Mob scene.
	print("spawning car")
	var car = car_scene.instantiate()

	# Choose a random location on Path2D.
	var car_spawn_location = $TrafficSpawn
	
	# Set the mob's position to a random location.
	car.position = car_spawn_location.position
	# Choose the velocity for the mob.
	car.linear_velocity = Vector2(-500.0, 0.0)

	# Spawn the mob by adding it to the Main scene.
	add_child(car)
