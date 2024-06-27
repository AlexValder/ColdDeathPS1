extends Node3D
class_name FoorPrinter

@export var player: PlayerChar

@onready var _normal := $normal as Timer

var foot_scene := preload("res://props/footprint.tscn") as PackedScene
var _last_left := false
var _mov_state: PlayerState = null


func _on_state_machine_state_changed(new_state: PlayerState) -> void:
    if !player or !player.is_on_floor():
        return

    match new_state.name:
        "idle":
            print_once(new_state)
        "walk", "run":
            print_normal(new_state)
        _:
            stop_print(new_state)


func get_footprint() -> FootPrint:
    var foot := foot_scene.instantiate() as FootPrint
    foot.ownership = 0b01
    return foot


func print_once(_state: PlayerState) -> void:
    stop_print(null)

    var foot1 := get_footprint()
    var foot2 := get_footprint()
    foot1.ready.connect(conf_foot.bind(foot1, false), CONNECT_ONE_SHOT)
    foot2.ready.connect(conf_foot.bind(foot2, true), CONNECT_ONE_SHOT)
    get_tree().current_scene.add_child.call_deferred(foot1)
    get_tree().current_scene.add_child.call_deferred(foot2)


func conf_foot(foot: FootPrint, left: bool) -> void:
    foot.global_position = global_position
    foot.rotation = player.global_rotation
    if left:
        foot.flip = true
        foot.offset(-0.25)
    else:
        foot.flip = false
        foot.offset(0.25)


func print_normal(state: PlayerState) -> void:
    _mov_state = state
    _normal.wait_time = 5.0/state.head_bob_freq
    print(5.0/state.head_bob_freq)
    _normal.start()


func stop_print(_state: PlayerState) -> void:
    _mov_state = null
    _normal.stop()


func _on_normal_timeout() -> void:
    var foot := get_footprint()
    foot.ready.connect(conf_foot.bind(foot, _last_left), CONNECT_ONE_SHOT)
    get_tree().current_scene.add_child.call_deferred(foot)
    _last_left = !_last_left

