class_name Character
extends CharacterBody2D

const  SPEED = 180.0

@export var jump_velocity = -300.0

var air_jumps = 2


func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("Izquierda", "Derecha")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Restart Double Jump
	if is_on_floor():
		air_jumps = 2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	#Handle Double Jump
	elif Input.is_action_just_pressed("Salto") and not is_on_floor() and air_jumps > 0:
		air_jumps -= 1
		velocity.y = jump_velocity
	
	#Handle Sprite Flip to turn the player
	if direction == 1:
		$Sprite2D.flip_h = true
	elif direction == -1:
		$Sprite2D.flip_h = false
	
	# Get the input direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
