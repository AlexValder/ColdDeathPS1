extends Camera3D
class_name PlayerCamera

@export var player := Player
var mouse_sens := 0.01/5
var joy_sens := 1.5
var _time := 0.0
var _tween: Tween = null

const CONSTANTS := {
    "freq_run": 20.0,
    "freq_crouch": 9.0,
    "freq_default": 9.0,
    "ampl_run": 0.7,
    "ampl_crouch": 0.4,
    "ampl_default": 0.5,
    "player_height": 1.7,
    "max_angle": PI/2,
    "min_angle": -5*PI/2,
}


func head_bob() -> void:
    var freq := _get_freq()
    var ampl := _get_ampl()
    var delta := get_physics_process_delta_time()
    _time += delta
    var movement = cos(_time * freq) * ampl

    if abs(player.velocity.x) || abs(player.velocity.z) > 0.1:
        position.y += movement * delta


func stop_head_bob() -> void:
    _time = 0.0
    create_tween().tween_property(self, "position:y",\
        CONSTANTS.player_height, 0.1).set_ease(Tween.EASE_OUT)


func _get_freq() -> float:
    if Input.is_action_pressed("run"):
        return CONSTANTS.freq_run
    elif Input.is_action_pressed("crouch"):
        return CONSTANTS.freq_crouch
    else:
        return CONSTANTS.freq_default


func _get_ampl() -> float:
    if Input.is_action_pressed("run"):
        return CONSTANTS.ampl_run
    elif Input.is_action_pressed("crouch"):
        return CONSTANTS.ampl_crouch
    else:
        return CONSTANTS.ampl_default


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        rotation.x = clampf(rotation.x - e.relative.y * mouse_sens,
            CONSTANTS.min_angle, CONSTANTS.max_angle)
    elif event.is_action_pressed("run"):
        _change_fov(80.0)
    elif event.is_action_released("run"):
        _change_fov(75.0)


func _process(delta: float) -> void:
    var look := Input.get_axis("look_up", "look_down")
    rotation.x = clampf(rotation.x + look * joy_sens * delta,
        CONSTANTS.min_angle, CONSTANTS.max_angle)


func _change_fov(new_fov: float) -> void:
    if _tween:
        _tween.kill()
        _tween = null

    _tween = create_tween()
    _tween.tween_property(self, "fov", new_fov, 0.2).set_ease(Tween.EASE_OUT_IN)
    _tween.play()
