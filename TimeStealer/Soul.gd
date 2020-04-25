extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const ACCELERATION = 500*24*8
var velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var target = null
var neighbours = []

func _physics_process(delta):
	if target != null:
		var dir = (target.position - self.position).normalized()
		velocity = velocity.move_toward(dir*2000, ACCELERATION)
		for neigh in neighbours:
			dir = (neigh.position - self.position).normalized()
			velocity = velocity.move_toward(-dir*300, ACCELERATION)
		velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if target == null and body.get_name().begins_with("Player"):
		target = body
	if body.get_name().begins_with("Soul"):
		neighbours.append(body)
	


func _on_ConsumingArea_body_entered(body):
	if body.get_name().begins_with("Player"):
		body.consume_time(-10)
		queue_free()


func _on_DetectingArea_body_exited(body):
	if body.get_name().begins_with("Soul"):
		neighbours.remove(neighbours.find(body))
