extends ColorRect

signal background_fade_finish

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("background_fade_finish")
