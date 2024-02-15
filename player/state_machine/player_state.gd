extends StateMachineState
class_name PlayerState

@export var player: PlayerChar


func on_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var e := event as InputEventMouseMotion
        player.rotate_y(-e.relative.x * player.camera.mouse_sens)


func look_around(delta: float) -> void:
    var look := Input.get_axis("look_right", "look_left") * player.camera.joy_sens
    player.rotate_y(look * delta)
