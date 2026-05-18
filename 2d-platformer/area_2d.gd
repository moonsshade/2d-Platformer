extends Area2D

@export var move_direction : Vector2
@export var move_speed : float = 20

@onready var start_pos : Vector2 = global_position
@onready var target_pos : Vector2 = global_position + move_direction

func _physics_process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)

	if global_position == target_pos: 
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos

func flip_visuals():
	"""
	Flips the enemy sprite horizontally (X-axis scale) 
	to visually represent a turn around.
	"""
	
	# Check the current direction to decide how to flip:
	if move_direction.x > 0: # Currently moving Right (Scale should be positive)
		scale.x = 1.0
	elif move_direction.x < 0: # Currently moving Left (Scale should be negative)
		scale.x = -1.0
	else: # Moving purely vertically (No horizontal flip needed, keep scale at 1.0)
		scale.x = 1.0
		
	# Optional: If you want to also change the animation state when flipping/turning
	$AnimationPlayer.play("walk") # Re-triggering ensures the walk loop restarts cleanly

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	body.take_damage(1)
	
