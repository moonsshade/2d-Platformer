extends CharacterBody2D

# --- Exported Variables (Adjustable in the Inspector) ---

@export var move_speed: float = 150.0  # How fast the enemy moves (pixels per second)
@export var walk_distance: float = 300.0 # The total distance to travel before turning (in pixels)


# --- Internal State Variables ---

var current_direction: Vector2 = Vector2.RIGHT # Start facing right
var distance_traveled_this_segment: float = 0.0 # Tracks how far we've moved in the current straight line segment


func _physics_process(delta: float) -> void:
	# 1. Calculate Movement (The core of walking forward)
	var velocity: Vector2 = current_direction * move_speed
	
	# 2. Apply Velocity and Move
	move_and_slide()
	
	# 3. Update Distance Traveled
	# We use the magnitude of the actual movement this frame (velocity * delta)
	var distance_moved_this_frame: float = velocity.length() * delta
	distance_traveled_this_segment += distance_moved_this_frame
	
	# 4. Check for Turn Condition
	if distance_traveled_this_segment >= walk_distance:
		change_direction()
		# Reset the counter so we start tracking from zero again
		distance_traveled_this_segment = 0.0


## Changes the enemy's direction and resets the travel tracker.
func change_direction():
	# Choose a new, random direction (e.g., Left, Right, Up, Down)
	var possible_directions: Array[Vector2] = [
		Vector2.RIGHT,  # 1, 0
		Vector2.LEFT,   # -1, 0
		Vector2.UP,     # 0, 1
		Vector2.DOWN    # 0, -1
	]
	
	# Pick one randomly
	var new_direction: Vector2 = possible_directions[randi() % possible_directions.size()]
	
	current_direction = new_direction
	print("Enemy turned! New direction: ", current_direction)
