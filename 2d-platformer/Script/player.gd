extends CharacterBody2D

@export var move_speed : float = 150
@export var acceleration : float = 50
@export var breaking : float = 20
@export var gravity : float = 500
@export var jump_force : float = 200

var move_imput : float 

@onready var sprite : Sprite2D = $Sprite
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 
	move_imput = Input.get_axis("move_left", "move_right")
	
	if move_imput != 0:
		velocity.x = lerp(velocity.x, move_imput * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, breaking * delta)
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()

func _process(delta):
	sprite.flip_h = velocity.x > 0
