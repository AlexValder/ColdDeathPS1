extends Node3D


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_play_button_up() -> void:
    get_tree().change_scene_to_file("res://levels/dev_level.tscn")


func _on_quit_button_up() -> void:
    get_tree().quit()


func _on_options_button_up() -> void:
    pass # Replace with function body.
