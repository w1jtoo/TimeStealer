extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationPlayer = $AnimationPlayer
var previousTextureId = 0
onready var rect = $TextureRect
onready var textures = [$"TextureRect/wizard idle", $TextureRect/wizard_move, $TextureRect/wizard_attack, $TextureRect/wizard_death]
var attack_cooldown = 0
var targets = []
var attackTargets = []
var projectileGenerator = preload("res://WizardProjectile.tscn")
var projectileCount = 0

var velocity = Vector2.ZERO

var time = 100
var deathTime = 0

var isRotationRight = false

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
			showTexture(5)
			animationPlayer.play("wizard_death")
		else:
			self.get_parent().remove_child(self)
		
	if attack_cooldown > 0:
		attack_cooldown-=1
		
	if len(attackTargets) > 0 and attack_cooldown <=0:
		if attack_cooldown ==0:
			attack_cooldown = -30
		else:
			attack_cooldown +=1
			animationPlayer.play("wizard_attack")
			showTexture(2)
			
		if attack_cooldown == 0:
			var index = 0
			var minDist = -1
			for i in range(len(attackTargets)):
				if minDist == -1 or self.position.distance_squared_to(attackTargets[i].position) < minDist:
					minDist = self.position.distance_squared_to(attackTargets[i].position)
					index = i
			if len(attackTargets) > index:
				attack(attackTargets[index])
	elif len(targets) > 0 and attack_cooldown >= 0:
		var index = 0
		var minDist = -1
		for i in range(len(targets)):
			var sqr = self.position.distance_squared_to(targets[i].position)
			if 100 < sqr && (minDist == -1 || sqr < minDist):
				minDist = self.position.distance_squared_to(targets[i].position)
				index = i
			
		if velocity != Vector2.ZERO and attack_cooldown >= 0:
			animationPlayer.play("wizard_move")
			showTexture(1)
		if minDist != -1:
			var dirVector = (targets[index].position - self.position).normalized()
			velocity = dirVector * 40
		else:
			velocity *= 0.7
		velocity = move_and_slide(velocity)
	else:
		attack_cooldown = 0
		showTexture(0)
		animationPlayer.play("wizard_idle")
		
func attack(target):
	var dir = (target.position - self.position).normalized()
	var projectile = projectileGenerator.instance()
	projectile.wizard = self
	projectile.velocity = dir * 200
	projectile.position = position + dir*30
	projectileCount+=1
	projectile.timeOut = 50
	self.attack_cooldown = 40
	self.get_parent().add_child(projectile,true)#"PROJECTILE"+str(projectileCount)+"ID"+str(self.get_rid())
	
	
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

func _on_Player_body_exited_search(body):
	if body in targets:
		targets.remove(targets.find(body))

func _on_Player_body_entered_search(body):
	if  body.get_name() == "Player":
		targets.append(body)
