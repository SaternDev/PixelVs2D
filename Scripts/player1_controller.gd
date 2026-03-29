class_name Player
extends CharacterBody2D

const  SPEED = 180.0

@onready var knockback_waiting: Timer = $KnockbackWaiting
const HIT_RECIBE_TESTER = preload("uid://dv07vvnftllw0")

var lifes = 3
var hitCounts = 0
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
	
	# Add the gravity.
	if not is_on_floor() and not inKnockback:
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
	if direction > 0.1:
		$Sprite2D.scale.x = 1
	elif direction < 0.1:
		$Sprite2D.scale.x = -1
	
	# Get the input direction and handle the movement/deceleration.
	if direction and not inKnockback:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()

#El Player a Muerto y se le resta una vida
func player_Death():
	lifes -= 1
	print("Player has dead")

#Recibe Knockback
func recibirKnockback(directionRightAttac, cantitiKnockback):
	inKnockback = true
	if knockback_waiting.is_stopped():
		knockback_waiting.start(0.2 + hitCounts*0.01)
	else:
		knockback_waiting.start(0.2 + hitCounts*0.01)
		
	if directionRightAttac:
		velocity.x = -1 * (cantitiKnockback * 100) - hitCounts * 100
	else:
		velocity.x = 1 * (cantitiKnockback * 100) + hitCounts * 100
		
	hitCounts += 1
	move_and_slide()

#Detecta si el cooldown de no poderse mover del knockback se ha terminado
func _on_knockback_waiting_timeout() -> void:
	inKnockback = false
