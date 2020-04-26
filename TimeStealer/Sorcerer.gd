extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationPlayer = $AnimationPlayer
var previousTextureId = 0
onready var textures = [$TextureRect/idle, $TextureRect/boss_attack, $TextureRect/death]

var projectileGenerator = preload("res://BossCharge.tscn")
var projectileCount = 0
var velocity = Vector2.ZERO

var attack_cooldown = 0
var time = 100
var deathTime = 0
var attackTargets = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	textures[previousTextureId].show()

func _physics_process(delta):
	if len(textures) > previousTextureId:
		textures[previousTextureId].flip_h = velocity.x > 0
	
	if time <= 0:
		if deathTime > 0:
			deathTime -= 1
			showTexture(2)
			animationPlayer.play("death")
		else:
			queue_free()
		
	if attack_cooldown > 0:
		attack_cooldown-=1
		
	if len(attackTargets) > 0 and attack_cooldown <=0:
		if attack_cooldown ==0:
			attack_cooldown = -30
		else:
			attack_cooldown +=1
			animationPlayer.play("attack")
			showTexture(1)
			
		if attack_cooldown == 0:
			var index = 0
			var minDist = -1
			for i in range(len(attackTargets)):
				if minDist == -1 or self.position.distance_squared_to(attackTargets[i].position) < minDist:
					minDist = self.position.distance_squared_to(attackTargets[i].position)
					index = i
			if len(attackTargets) > index:
				attack(attackTargets[index])
	else:
		attack_cooldown = 0
		showTexture(0)
		animationPlayer.play("idle")
		
	
func attack(target):
	var dir = (target.position - self.position).normalized()
	var projectile = projectileGenerator.instance()
	projectile.wizard = self
	projectile.velocity = dir * 200*8
	projectile.position = position + dir*30*8
	projectileCount+=1
	projectile.timeOut = 50*8
	self.attack_cooldown = 160
	self.get_parent().add_child(projectile,true)
	

func hit(damage):
	time -= damage
	if time <= 0:
		deathTime = 20
		
		
func showTexture(textureId):
	if textureId != previousTextureId:
		if textures[previousTextureId] != null:
			textures[previousTextureId].hide()
		if textures[textureId] != null:
			textures[textureId].show()
		previousTextureId = textureId


func _on_Player_body_entered(body):
	if  body.get_name() == "Player":
		attackTargets.append(body)


func _on_Player_body_exited(body):
	if body in attackTargets:
		attackTargets.remove(attackTargets.find(body))
