extends CharacterBody3D
class_name PlayerChar

@onready var camera := $shape/camera as PlayerCamera
@onready var _shape := $shape as CollisionShape3D
@onready var _cyl_shape := _shape.shape as CapsuleShape3D
@onready var _machine := $state_machine as FiniteStateMachine
@onready var health := $health as RenewableStat
@onready var stamina := $stamina as RenewableStat

var _height_tween: Tween = null


func change_height(to: float) -> void:
    if _height_tween:
        _height_tween.kill()
        _height_tween = null

    _height_tween = create_tween()
    _height_tween.set_parallel()
    _height_tween.tween_property(_cyl_shape, "height", to, 0.1)\
        .set_ease(Tween.EASE_OUT)
    _height_tween.tween_property(_shape, "position:y", to/2, 0.1)\
        .set_ease(Tween.EASE_OUT)
    _height_tween.play()


func _ready() -> void:
    _machine.change_state("idle")


func _on_state_machine_state_changed(new_state: PlayerState) -> void:
    ($HUD/state as Label).text = new_state.name
