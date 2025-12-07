class_name Character
extends CharacterBody2D

const  SPEED = 180.0

var LIFES = 3
@export var jump_velocity = -300.0
@export var respawnLocation:Vector2 = Vector2(510., 550.)

var air_jumps = 2

var inKnockback:bool = false

func _process(_delta: float) -> void:
	if position.y > 2000:
		position = respawnLocation
		player_Death()


func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("Izquierda", "Derecha")
	
	if not inKnockback:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
	
	#Restart Double Jump
	if is_on_floor():
		air_jumps = 2


	#Te deja saltar si no estás recibiendo knockback
	if not inKnockback:	
		# Handle jump.
		if Input.is_action_just_pressed("Salto") and is_on_floor():
			velocity.y = jump_velocity
		#Handle Double Jump
		elif Input.is_action_just_pressed("Salto") and not is_on_floor() and air_jumps > 0:
			air_jumps -= 1
			velocity.y = jump_velocity
	
	#Handle Sprite Flip to turn the player
	if direction != 0:
		$Sprite2D.scale.x = direction
	
	#No te deja moverte cuando estas reciviendo knockback
	if not inKnockback:
		# Get the input direction and handle the movement/deceleration.
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	
	move_and_slide()


func player_Death():
	print("Player has dead")


func recibirKnockback(cantidadKnockback):
	#Futura función para recibir knockback y que te lance hacia atrás
	print("Knockback")
