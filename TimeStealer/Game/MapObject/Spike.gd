extends Area2D

onready var start_animation_time = OS.get_ticks_msec()
onready var next_attack_time = 0
var last_bodies = []
export var attack_cooldown = 858
export var spike_damage = 50

func _physics_process(delta):
	for body in last_bodies:
		if body != null and body.name.begins_with("Player"):
			var now = OS.get_ticks_msec()
			var animation_time = (now - start_animation_time) % 2000
			if 857 <= animation_time and animation_time < 1714 and now > next_attack_time:
				# print("trying to deal damage")
				next_attack_time = now + attack_cooldown
				body.hit(spike_damage)


func _on_Spike_body_entered(body):
	# print(body.name)
	last_bodies.append(body)


func _on_Spike_body_exited(body):
	var i = 0
	for last_body in last_bodies:
		if last_body.name == body.name:
			last_bodies.remove(i)
		
		i += 1
