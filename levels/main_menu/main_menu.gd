extends Node3D


@onready var _main_vbox := $%main_vbox as VBoxContainer
@onready var _settings := $%settings_vbox as VBoxContainer


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    _main_vbox.visible = true
    _settings.visible = false


func _on_play_button_up() -> void:
    get_tree().change_scene_to_file("res://levels/dev_level.tscn")


func _on_quit_button_up() -> void:
    get_tree().quit()


func _on_options_button_up() -> void:
    _main_vbox.visible = false
    _settings.visible = true


func _on_back_button_up() -> void:
    _settings.visible = false
    _main_vbox.visible = true
