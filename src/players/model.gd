class_name Model
extends Node3D

enum States { MOVE, STROKE }
enum Strokes {
	BACKHAND,
	BACKHAND_SLICE,
	FOREHAND,
	SERVE,
}

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var _playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@onready var points = $Points
@onready var serve_point = points.get_node("BallServePoint").position
@onready var toss_point = points.get_node("BallTossPoint").position
@onready var forehand_up_point = points.get_node("ForehandUpPoint").position
@onready var forehand_down_point = points.get_node("ForehandDownPoint").position
@onready var backhand_up_point = points.get_node("BackhandUpPoint").position
@onready var backhand_down_point = points.get_node("BackhandDownPoint").position
@onready var backhandslice_up_point = points.get_node("BackhandSliceUpPoint").position
@onready var backhandslice_down_point = points.get_node("BackhandSliceDownPoint").position

@onready var racket_forehand: Area3D = $RacketForehand
@onready var racket_backhand: Area3D = $RacketBackhand


func _ready() -> void:
	animation_tree.active = true


func set_move_direction(direction: Vector3) -> void:
	var dir := Vector2(direction.x, direction.z)
	#animation_tree["parameters/move/blend_position"] = dir


func get_stroke_blend_position(stroke_id: int, stroke_pos: Vector3) -> Vector3:
	var point_down := Vector3.ZERO
	var point_up := Vector3.ZERO
	#match stroke_id:
	#Strokes.FOREHAND:
	#point_down = forehand_down_point
	#point_up = forehand_up_point
	#Strokes.BACKHAND:
	#point_down = backhand_down_point
	#point_up = backhand_up_point
	#Strokes.BACKHAND_SLICE:
	#point_down = backhandslice_up_point
	#point_up = backhandslice_down_point

	return (stroke_pos - point_down) / (point_up - point_down)


func set_stroke(stroke_name: String, stroke_pos := Vector3.ZERO) -> void:
	#var point := get_stroke_blend_position(stroke_id, stroke_pos)
	#animation_tree["parameters/stroke/forehand/blend_position"] = point.y
	#animation_tree["parameters/stroke/backhand/blend_position"] = point.y
	#animation_tree["parameters/stroke/backhand_slice/blend_position"] = point.y
	animation_tree["parameters/stroke/Transition/transition_request"] = stroke_name
	pass


func transition_to(state_id: int) -> void:
	match state_id:
		States.MOVE:
			_playback.travel("move")
		States.STROKE:
			_playback.travel("stroke")
		#_:
		#_playback.travel("move")
