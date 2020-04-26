extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var caster = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var timer = 200

func _physics_process(delta):
	for b in targets:
		print(b.get_name())
		var deltaVelocity = b.velocity*0.1
		b.velocity = b.velocity-deltaVelocity
		if caster != null:
			caster.consume_time(-deltaVelocity.length()/8/100)
	
	if timer > 0:
		timer -= 1
	else:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var targets = []

func _on_Area2D_body_entered(body):
	targets.append(body)


func _on_Area2D_body_exited(body):
	targets.remove(targets.find(body))
