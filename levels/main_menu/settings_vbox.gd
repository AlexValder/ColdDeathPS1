extends VBoxContainer


func _ready() -> void:
    ($settings_grid/vsync as Button).button_pressed =\
        DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
    ($"settings_grid/43res" as Button).button_pressed =\
        get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP


func _on_vsync_toggled(toggled_on: bool) -> void:
    DisplayServer.window_set_vsync_mode(
        DisplayServer.VSYNC_ENABLED if toggled_on else
        DisplayServer.VSYNC_DISABLED)


func _on_res_toggled(toggled_on: bool) -> void:
    get_tree().root.content_scale_aspect =\
        Window.CONTENT_SCALE_ASPECT_KEEP if toggled_on else\
        Window.CONTENT_SCALE_ASPECT_KEEP_HEIGHT
