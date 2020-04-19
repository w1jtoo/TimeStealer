extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# func _ready():
#	print("123") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2.DOWN)
	if Input.is_action_pressed("ui_up"):
		move_and_collide(Vector2.UP)
		animation.
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2.LEFT)
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2.RIGHT)
	
