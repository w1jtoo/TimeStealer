extends KinematicBody2D

var velocity = Vector2.ZERO*200
var stableVelocity = Vector2.ZERO
var timeOut = 50*8
var caster = null

var isDestructing = false
var destructionTime = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	stableVelocity = velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var collider = $CollisionPolygon2D
onready var area = $Area2D/CollisionShape2D
onready var texture = $TextureRect/ice_arrow


func _physics_process(delta):	
	var angle = -velocity.angle_to(Vector2.RIGHT)
	collider.rotation = angle
	area.rotation = angle+PI/2
	texture.rotation = angle
	
	if timeOut > 0:
		timeOut-=1
	else:
		isDestructing = true
	if isDestructing:
		if destructionTime > 0:
			destructionTime-=1
		else:
			queue_free()
		
	velocity = move_and_slide(velocity)
	if (stableVelocity - velocity).length() > 0:
		isDestructing = true
		collider.disabled = true
		velocity = velocity.normalized()
		
var targets = ["Wizard", "Sorcerer", "TimeUrn"]

func _on_Area2D_body_entered(body):
	if isValid(body):
		if not isDestructing:
			body.hit(20)
			if caster != null:
				caster.consume_time(-20)
			isDestructing = true

func isValid(body):
	for t in targets:
		if body.get_name().begins_with(t):
			return true
	return false
