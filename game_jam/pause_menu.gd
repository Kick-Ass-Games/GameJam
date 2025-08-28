extends CanvasLayer

var paused = false;

func switch_pause():
	paused = !paused;
	get_tree().paused = paused;
	self.visible = paused;

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		switch_pause();

func _on_resume_button_pressed() -> void:
	switch_pause();

func _on_settings_button_pressed() -> void:
	var pause_menu = get_node("pause_menu");
	var settings_menu = get_node("settings_menu");
	
	pause_menu.visible = false;
	settings_menu.visible = true;

func _on_quit_button_pressed() -> void:
	get_tree().quit();

func _on_back_button_pressed() -> void:
	var pause_menu = get_node("pause_menu");
	var settings_menu = get_node("settings_menu");
	
	pause_menu.visible = true;
	settings_menu.visible = false;
