extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_damaged(value, max_value):
	bar.value = 100*value/(max_value+0.00001)
