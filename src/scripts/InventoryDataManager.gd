extends Node

var item_list : Array = []

onready var gridContainer = get_node("../Panel/GridContainer")

class ItemAmount:
	var item: ItemData = null
	var amount: int = 0
	
	func _init(_amount: int, _item_type: ItemData):
		amount = _amount
		item = _item_type

func _append_item(item, amount: int = 1, slot = null) -> void:
	if item is ItemAmount:
		item_list.append(item)
		_reload_icon_items()
	elif item is ItemData:
		var item_amount_id = _find_item_id(item)
		
		if item_amount_id != -1 and item.category == "Stackable":
			item_list[item_amount_id].amount += amount
		else:
			if slot:
				var new = ItemAmount.new(amount, item)
				item_list.append(new)
				gridContainer.get_node(slot).get_node("Icon").item = new
			else:
				item_list.append(ItemAmount.new(amount, item))
		_reload_icon_items()

func _remove_item(item, amount: int = 1) -> void:
	var item_amount_id = _find_item_id(item)
	
	if item_amount_id == -1:
		if item is ItemAmount:
			push_error("%s could not be removed from the list. No itemAmount corresponding was found" % item.item.item_name)
		else:
			push_error("%s could not be removed from the list. No itemAmount corresponding was found" % item.item_name)
	else:
		item_list[item_amount_id].amount -= amount
		if item_list[item_amount_id].amount <= 0:
			item_list.remove(item_amount_id)

func _find_item_id(item) -> int:
	if item is ItemAmount:
		for i in range(item_list.size()):
			var item_amount = item_list[i]
			if item_amount.item.item_name == item.item.item_name:
				return i
	elif item is ItemData:
		for i in range(item_list.size()):
			var item_amount = item_list[i]
			if item_amount.item.item_name == item.item_name:
				return i
	return -1

func _print_inventory() -> void:
	print("--- INVENTORY CONTENT ---")
	print(" ")
	
	for item in item_list:
		print(item.item.item_name + " : " + String(item.amount))
	
	# For testing purposes
	#
	_test()
	#_reload_icon_items()
	
	print(" ")
	print("--- -------- ------- ---")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		_print_inventory()

func _load_current_drawed_items():
	var list = []
	for i in range(30):
		var scene = gridContainer.get_node("Slot" + String(i + 1)).get_node("Icon")
		if scene.item != null:
			list.append(scene.item)
	return list

func _reload_icon_items() -> void: 
	var drawed_items = _load_current_drawed_items()
	for item in item_list:
		if drawed_items.find(item) == -1:
			# Si l'item n'est actuellement pas affiché
			# Trouver le premier slot vide et lui faire charger l'item
			for i in range(30):
				var scene = gridContainer.get_node("Slot" + String(i + 1)).get_node("Icon")
				if scene.item == null:
					scene._load(item)
					scene._load_texture()
					break

func _test():
	var stats = ItemData.new()
	stats.category = "weapon"
	stats.type = "sword"
	stats.item_name = "sword"
	
	_append_item(stats)

func _on_object_collected(item: Resource) -> void:
	if item is ItemData:
		_append_item(item)
		_print_inventory()

func _on_ProfileDataManager_addItemtoInventory(item):
	if item is ItemAmount:
		_append_item(item)

func _on_Icon_addItemtoInventorySlot(item, slot):
	_append_item(item, slot)

func _on_Icon_removeItemFromInventory(item):
	_remove_item(item)
