extends Node2D

onready var icon = $Icon
var item

func _load(item_):
	item = item_

func _load_texture() -> void:
	var path = "res://src/img/Items/Inventory/" + item.name + ".png"
	var icon_texture = load(path)
	icon.set_texture(icon_texture)
