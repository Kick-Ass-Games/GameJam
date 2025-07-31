extends Control

var paused = false

func unpause():
	paused = !paused;
	self.visible = paused;

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		unpause()

func _on_resume_button_pressed() -> void:
	unpause();

func _on_settings_button_pressed() -> void:
	self.get_node("paused_segment").visible = false;
	self.get_node("setting_menu").visible = true;

func _on_back_button_pressed() -> void:
	self.get_node("paused_segment").visible = true;
	self.get_node("setting_menu").visible = false;


func _on_quit_button_pressed() -> void:
	get_tree().quit()
