extends Node3D


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        get_tree().change_scene_to_file("res://levels/main_menu.tscn")
    #elif event.is_action_pressed("restart"):
        #get_tree().reload_current_scene()
