extends Control
class_name Inventory

onready var tween = $Tween
onready var panel = $Panel
onready var hidden_position = panel.rect_position
onready var x = panel.rect_position.x - 25
onready var y = panel.rect_position.y
onready var visible_position = Vector2(x, y) - panel.rect_size * Vector2.RIGHT

var hidden := true setget set_hidden, is_hidden

signal InventoryHidden_changed(value)

func set_hidden(value: bool) -> void:
	if value != hidden:
		hidden = value
		emit_signal("InventoryHidden_changed", hidden)
func is_hidden() -> bool: return hidden

func _ready():
	var __ = connect("InventoryHidden_changed", self, "_on_InventoryHidden_changed")

func _animation(appear: bool) -> void:
	var _from = panel.rect_position
	var _to = visible_position if !appear else hidden_position
	
	# Temporary (This code works but the animation doesn't)
	panel.rect_position.x = _to.x
	#tween.interpolate_property(panel, "rect_position:x", _from, _to, 1, Tween.TRANS_LINEAR)
	#tween.start()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		set_hidden(!hidden)

func _on_InventoryHidden_changed(_value: bool):
	_animation(_value)

