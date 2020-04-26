extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bar = $ProgressBar

onready var spellIcons = [$"Panel2/TextureRect/Panel", 
	$"Panel2/TextureRect/ice-blue-3",
	$"Panel2/TextureRect/leaf-jade-3", 
	$"Panel2/TextureRect/runes-orange-3"]
var previousSpell = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_damaged(value, max_value):
	bar.value = 100*value/(max_value+0.00001)


func _on_Player_spell_changed(type):
	spellIcons[previousSpell].visible = false
	spellIcons[type].visible = true
	previousSpell = type
