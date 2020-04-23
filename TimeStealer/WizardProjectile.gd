extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO*200
var timeOut = 50
var wizard = null

var isDestructing = false
var destructionTime = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var collisionBox = $CollisionShape2D
onready var area = $Area2D/CollisionShape2D

onready var animationPlayer = $AnimationPlayer
var previousTextureId = 0
onready var textures = [$TextureRect/projectile_idle, $TextureRect/projectile_destruction]

func _physics_process(delta):
	var angle = -velocity.angle_to(Vector2.LEFT)
	collisionBox.rotation = angle
	area.rotation = angle
	if len(textures) > previousTextureId:
		textures[previousTextureId].rotation = angle
	
	if timeOut > 0:
		timeOut-=1
	else:
		isDestructing = true
	if isDestructing:
		showTexture(1)
		animationPlayer.play("death")
		if destructionTime > 0:
			destructionTime-=1
		else:
			self.get_parent().remove_child(self)
	else:
		animationPlayer.play("idle")
		
	var newVelocity = move_and_slide(velocity)
	if newVelocity != velocity:
		isDestructing = true


func _on_Area2D_body_entered(body):
	if  body.get_name() == "Player":
		if not isDestructing:
			body.hit(20)
			isDestructing = true

func showTexture(textureId):
	if textureId != previousTextureId:
		if textures[previousTextureId] != null:
			textures[previousTextureId].hide()
		if textures[textureId] != null:
			textures[textureId].show()
		previousTextureId = textureId
