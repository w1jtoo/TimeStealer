extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 150
const FRICTION = 500

var attack_cooldown_time = 1000
var next_attack_time = 0
var attack_damage = 30

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

#func _input(event):
	#if event.is_action_pressed("attack"):
		# Check if player can attack
		#var now = OS.get_ticks_msec()
		#if now >= next_attack_time:
			# Play attack animation
			# attack_playing = true
			#var animation = get_animation_direction(last_direction) + "_attack"
			#$Sprite.play(animation)
			# Add cooldown time to current time
			#next_attack_time = now + attack_cooldown_time

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# velocity = move_and_slide(velocity)
	
