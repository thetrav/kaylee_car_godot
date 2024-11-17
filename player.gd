extends Area2D

signal hit

const GRAVITY = 1200

@export var jump_power = 500
var screen_size
var jumping = false
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("jump") and not jumping:
		velocity.y = -jump_power
		jumping = true
	if jumping:
		velocity.y += GRAVITY * delta
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		if position.y >= 560:
			velocity = Vector2.ZERO
			position.y = 560
			jumping = false
		$AnimatedSprite2D.animation = "jump"
	else:
		$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	$Debug.text = "velocity %f\nposition %f" % [velocity.y, position.y]
	


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
