extends Camera3D
class_name PlayerCamera

const MAX_ANGLE := PI/2
const MIN_ANGLE := -5*PI/12

var mouse_sens := 0.01/5
var joy_sens := 1.5


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        rotation.x = clampf(rotation.x - e.relative.y * mouse_sens,
            MIN_ANGLE, MAX_ANGLE)


func _process(delta: float) -> void:
    var look := Input.get_axis("look_up", "look_down")
    rotation.x = clampf(rotation.x + look * joy_sens * delta, MIN_ANGLE, MAX_ANGLE)
