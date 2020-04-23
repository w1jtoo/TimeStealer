extends Area2D

onready var next_attack_time = 0
onready var attack_cooldown = 1000
var last_bodies = []

func _physics_process(delta):
	for body in last_bodies:
		if body != null and body.name.begins_with("Player"):
			var now = OS.get_ticks_msec()
			if now >= next_attack_time:
				# print("trying to deal damage")
				next_attack_time = now + attack_cooldown
				body.hit(20)


func _on_Spike_body_entered(body):
	# print(body.name)
	last_bodies.append(body)


func _on_Spike_body_exited(body):
	var i = 0
	for last_body in last_bodies:
		if last_body.name == body.name:
			last_bodies.remove(i)
		
		i += 1
