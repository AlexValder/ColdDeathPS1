extends Node3D
class_name FootPrint

@export_range(-180.0, 180.0, 0.5) var rot := 6.0
@export_range(0.0, 360.0, 0.1) var life_timer := 5.0
@export_range(0.0, 60.0, 0.1) var fade_timer := 1.0
@export_flags("Player", "Enemy", "Monster") var ownership := 0

@onready var _timer := $timer as Timer
@onready var _print := $print as Sprite3D

var flip: bool:
    get:
        if !_print:
            push_error("_print is null")
            return false
        else:
            return _print.flip_h
    set(value):
        if _print:
            _print.flip_h = value
            _print.rotation.y = rot * (-1 if value else 1)
        else:
            push_error("_print is null")


func offset(step_offset: float) -> void:
    _print.position.x += step_offset


func _ready() -> void:
    _timer.start(life_timer)


func _on_timer_timeout() -> void:
    var t := create_tween()
    t.tween_property(_print, "modulate:a", 0.0, fade_timer)
    t.tween_callback(queue_free)
    t.play()
