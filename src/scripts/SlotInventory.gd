extends TextureRect

signal addItemtoInventorySlot(item, slot)
signal removeItemFromInventory(item)

var item = null

func _load(item_):
	item = item_

func _load_texture() -> void:
	var path = "res://src/img/Items/Inventory/" + item.item.item_name + ".png"
	var icon_texture = load(path)
	set_texture(icon_texture)

func get_drag_data(_pos):
	if item != null:
		var data = {}
		data["from"] = self
		data["panel"] = "Inventory"
		data["item"] = item
		data["fromSlot"] = get_parent().get_name()
		data["texture"] = texture
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = texture
		drag_texture.rect_size = rect_size
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		
		return data

func can_drop_data(_pos, data):
	if data["panel"] == "Inventory":
		return true
	elif data["panel"] == "Profile":
		return true
	else: return false

func drop_data(_pos, data):
	if data["panel"] == "Inventory":
		if item != null:
			emit_signal("removeItemFromInventory", data["item"])
			emit_signal("addItemtoInventorySlot", item, data["fromSlot"])
			emit_signal("addItemtoInventorySlot", data["item"], get_parent().get_name())
	elif data["panel"] == "Profile":
		return true
