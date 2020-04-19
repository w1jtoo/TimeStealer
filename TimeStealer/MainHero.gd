extends KinematicBody2D

func _ready():
	print("123")
	set_physics_process(true)

func _physics_process(delta):
	print("im here")
	var vel = Vector2.DOWN
	if Input.is_action_pressed("ui_down"):
		print("Hello word") 
		move_and_collide(vel * delta)
	
	
