extends CharacterBody3D
class_name Player

const SPEED := 3.0
const RUN_SPEED := 5.0
const CROUCH_SPEED := 2.0
const GRAVITY := 98.0*1.5

@onready var camera := $camera as PlayerCamera
@onready var _shape := $shape as CollisionShape3D
@onready var _cyl_shape := _shape.shape as CapsuleShape3D

var _tween: Tween = null


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        rotate_y(-e.relative.x * camera.mouse_sens)
    elif event.is_action_pressed("crouch"):
        if _tween:
            _tween.kill()
            _tween = null

        _tween = create_tween()
        _tween.tween_property(_cyl_shape, "height", 0.9, 0.1)\
            .set_ease(Tween.EASE_OUT)
        _tween.play()
    elif event.is_action_released("crouch"):
        if _tween:
            _tween.kill()
            _tween = null

        _tween = create_tween()
        _tween.tween_property(_cyl_shape, "height", 2, 0.1)\
            .set_ease(Tween.EASE_OUT)
        _tween.play()


func _physics_process(delta: float) -> void:
    var movement := Input.get_vector("left", "right", "forward", "backwards")
    var look := Input.get_axis("look_right", "look_left") * camera.joy_sens

    rotate_y(look * delta)

    velocity = global_transform.basis *\
        Vector3(movement.x, -GRAVITY * delta, movement.y) * _speed()
    move_and_slide()


func _speed() -> float:
    if Input.is_action_pressed("run"):
        return RUN_SPEED
    elif Input.is_action_pressed("crouch"):
        return CROUCH_SPEED
    else:
        return SPEED
