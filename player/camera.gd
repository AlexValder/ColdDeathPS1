extends Camera3D
class_name PlayerCamera

@export var player: PlayerChar
var mouse_sens := 0.01/5
var joy_sens := 1.5
var _time := 0.0
var _tween: Tween = null
var _freq := 0.0
var _ampl := 0.0
var _is_bobbing := false

const MAX_ANGLE := PI/2
const MIN_ANGLE := -5*PI/12
const PLAYER_HEIGHT := 0.7


func start_head_bob(freq: float, ampl: float) -> void:
    _freq = freq
    _ampl = ampl
    _is_bobbing = true


func _physics_process(delta: float) -> void:
    if _is_bobbing:
        _head_bob(_freq, _ampl, delta)


func _head_bob(freq: float, ampl: float, delta: float) -> void:
    _time += delta
    var movement: = absf(cos(_time * freq)) * ampl

    if abs(player.velocity.x) || abs(player.velocity.z) > 0.1:
        position.y = PLAYER_HEIGHT + movement * delta


func stop_head_bob() -> void:
    _is_bobbing = false
    _time = 0.0
    create_tween().tween_property(self, "position:y",\
        PLAYER_HEIGHT, 0.05).set_ease(Tween.EASE_OUT)


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        rotation.x = clampf(rotation.x - e.relative.y * mouse_sens,
            MIN_ANGLE, MAX_ANGLE)


func _process(delta: float) -> void:
    var look := Input.get_axis("look_up", "look_down")
    rotation.x = clampf(rotation.x + look * joy_sens * delta,
        MIN_ANGLE, MAX_ANGLE)


func change_fov(new_fov: float) -> void:
    if _tween:
        _tween.kill()
        _tween = null

    _tween = create_tween()
    _tween.tween_property(self, "fov", new_fov, 0.2).set_ease(Tween.EASE_OUT_IN)
    _tween.play()
