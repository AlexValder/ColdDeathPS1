extends CharacterBody3D
class_name PlayerChar


@onready var camera := $shape/camera as PlayerCamera
@onready var _shape := $shape as CollisionShape3D
@onready var _cyl_shape := _shape.shape as CapsuleShape3D
@onready var _machine := $state_machine as FiniteStateMachine

var _tween: Tween = null


func change_height(to: float) -> void:
    if _tween:
        _tween.kill()
        _tween = null

    _tween = create_tween()
    _tween.set_parallel()
    _tween.tween_property(_cyl_shape, "height", to, 0.1)\
        .set_ease(Tween.EASE_OUT)
    _tween.tween_property(_shape, "position:y", to/2, 0.1)\
        .set_ease(Tween.EASE_OUT)
    _tween.play()


func _ready() -> void:
    camera.player = self
    _machine.change_state("idle")


func _on_state_machine_state_changed(new_state: PlayerState) -> void:
    ($HUD/state as Label).text = new_state.name
