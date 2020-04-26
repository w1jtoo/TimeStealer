extends Control

signal background_fade_finish

var scene_path_to_load

func _ready():
	pass
	
func _on_Button_pressed(scene_to_load):
	# get_tree().change_scene(scene_to_load)
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finish():
	get_tree().change_scene(scene_path_to_load)


func _on_ExitButton_pressed():
	_on_Button_pressed($Buttons/ExitButton.scene_to_load)


func _on_OptionsButton_pressed():
	_on_Button_pressed($Buttons/OptionsButton.scene_to_load)

func _on_RestartButton_button_up() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func background_fade_in():
	$BackgroundFadeIn/AnimationPlayer.play("BackgroundFadeIn")
	
func rev_background_fade_in():
	$BackgroundFadeIn/AnimationPlayer.play("RevFadeIn")


func _on_BackgroundFadeIn_background_fade_finish():
	emit_signal("background_fade_finish")


func _on_Back_button_up():
	rev_background_fade_in()
