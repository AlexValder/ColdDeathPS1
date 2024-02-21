extends Node
class_name RenewableStat

@export var max_value: float = 10.0
@export var min_value: float = 0.0
@export var value: float = 10.0:
    set(new_value):
        _set_text(new_value)
        value = new_value
@export var delay: float = 1.0
@export var duration: float = 5.0
@export_node_path("Label") var output: NodePath

var _label: Label = null
var _tween: Tween = null


func can_retract(tax: float) -> bool:
    return value >= tax


func try_retract(tax: float) -> bool:
    if value >= tax:
        value -= tax
        return true
    return false


func start_recover() -> void:
    stop_recover()

    _tween = create_tween()
    _tween.tween_property(self, "value", max_value, _calc_dur())\
        .set_delay(delay)
    _tween.play()


func stop_recover() -> void:
    if _tween:
        _tween.kill()
        _tween = null


func _calc_dur() -> float:
    print((max_value - value) * duration / max_value)
    return (max_value - value) * duration / max_value


func _set_text(val: float) -> void:
    if _label:
        _label.text = "%3.3f" % val


func _ready() -> void:
    assert(min_value <= value)
    assert(value <= max_value)
    assert(delay >= 0)
    assert(duration > 0)

    if output && !output.is_empty():
        _label = get_node(output)
        if is_instance_valid(_label):
            _set_text(value)
