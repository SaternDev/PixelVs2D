extends Area2D

@export var rightAttack = true
@export var cantitiKnockback = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Hit Player")
		if body.has_method("recibirKnockback"):
			body.recibirKnockback(rightAttack, cantitiKnockback)
