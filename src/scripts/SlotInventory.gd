extends TextureRect

signal addItemtoInventorySlot(item, slot)
signal removeItemFromInventory(item)

var item = null

func _ready():
	expand = true

func _load(item_):
	item = item_

func _load_texture() -> void:
	var path = "res://src/img/Items/Inventory/" + item.item.item_name + ".png"
	var icon_texture = load(path)
	set_texture(icon_texture)

func get_drag_data(_pos):
	print("Calling get drag data")
	if item != null:
		print("Getting drag data")
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
	print("Calling can drop data")
	if data["panel"] == "Inventory":
		return true
	elif data["panel"] == "Profile":
		return true
	else: return false

func drop_data(_pos, data):
	print("Calling drop data")
	if data["panel"] == "Inventory":
		if item != null:
			emit_signal("removeItemFromInventory", data["item"])
			emit_signal("addItemtoInventorySlot", item, data["fromSlot"])
			emit_signal("addItemtoInventorySlot", data["item"], get_parent().get_name())
			item = data["item"]
	elif data["panel"] == "Profile":
		return true

var mouse_pressed = false

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
			print("Mouse clicked")
		else:
			mouse_pressed = false

func _on_mouse_entered():
	print("Mouse entered")
	if mouse_pressed:
		print("button is drag-pressed!")
