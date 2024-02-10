extends CharacterBody3D
class_name Player

const SPEED := 2.0
const GRAVITY := 98.0*1.5

@onready var camera := $camera as Camera3D
@onready var _shape := $shape as CollisionShape3D


func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        rotate_y(e.relative.x)


func _physics_process(delta: float) -> void:
    var movement := Input.get_vector("left", "right", "forward", "backwards")
    var look := Input.get_axis("look_right", "look_left")

    rotate_y(look * delta)

    velocity = global_transform.basis *\
        Vector3(movement.x, -GRAVITY * delta, movement.y) * SPEED
    move_and_slide()
