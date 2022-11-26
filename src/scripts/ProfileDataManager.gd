extends Node

onready var SlotFirstWeapon = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotFirstWeapon")
onready var SlotSecondWeapon = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotSecondWeapon")
onready var SlotHelmet = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotHelmet")
onready var SlotChestplate = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotChestplate")
onready var SlotPants = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotPants")
onready var SlotBoots = get_node("/root/LevelTemplate/UI_Container/Profile/Panel/SlotBoots")

onready var SceneFirstWeapon = SlotFirstWeapon.get_node("Icon")
onready var SceneSecondWeapon = SlotSecondWeapon.get_node("Icon")
onready var SceneHelmet = SlotHelmet.get_node("Icon")
onready var SceneChestplate = SlotChestplate.get_node("Icon")
onready var ScenePants = SlotPants.get_node("Icon")
onready var SceneBoots = SlotBoots.get_node("Icon")

onready var equipped = {
	"FirstWeapon": null,
	"SecondWeapon": null,
	"Helmet": null,
	"Chestplate": null,
	"Pants": null,
	"Boots": null}

signal addItemtoInventory(item)

func _change_item(scene: String, item) -> void:
	match scene:
		"SceneFirstWeapon":
			if equipped["FirstWeapon"] == null:
				equipped["FirstWeapon"] = item
				SceneFirstWeapon._load(item)
				SceneFirstWeapon._load_texture()
				print(item)
			else:
				emit_signal("addItemtoInventory", equipped["FirstWeapon"])
				equipped["FirstWeapon"] = item
				SceneFirstWeapon._load(item)
				SceneFirstWeapon._load_texture()
		"SceneSecondWeapon":
			if equipped["SecondWeapon"] == null:
				equipped["SecondWeapon"] = item
				SceneSecondWeapon._load(item)
				SceneSecondWeapon._load_texture()
			else:
				emit_signal("addItemtoInventory", equipped["SecondWeapon"])
				equipped["SecondWeapon"] = item
				SceneSecondWeapon._load(item)
				SceneSecondWeapon._load_texture()
		"SceneHelmet":
			if equipped["Helmet"] == null:
				equipped["Helmet"] = item
				SceneHelmet._load(item)
				SceneHelmet._load_texture()
			else:
				emit_signal("addItemtoInventory", equipped["Helmet"])
				equipped["Helmet"] = item
				SceneHelmet._load(item)
				SceneHelmet._load_texture()
		"SceneChestplate":
			if equipped["Chestplate"] == null:
				equipped["Chestplate"] = item
				SceneChestplate._load(item)
				SceneChestplate._load_texture()
			else:
				emit_signal("addItemtoInventory", equipped["Chestplate"])
				equipped["Chestplate"] = item
				SceneChestplate._load(item)
				SceneChestplate._load_texture()
		"ScenePants":
			if equipped["Pants"] == null:
				equipped["Pants"] = item
				ScenePants._load(item)
				ScenePants._load_texture()
			else:
				emit_signal("addItemtoInventory", equipped["Pants"])
				equipped["Pants"] = item
				ScenePants._load(item)
				ScenePants._load_texture()
		"SceneBoots":
			if equipped["Boots"] == null:
				equipped["Boots"] = item
				SceneBoots._load(item)
				SceneBoots._load_texture()
			else:
				emit_signal("addItemtoInventory", equipped["Boots"])
				equipped["Boots"] = item
				SceneBoots._load(item)
				SceneBoots._load_texture()
		"_":
			push_error("SCENE NOT FOUND: argument is not a valid scene")

func _on_InventoryDataManager_equip(item, scene):
	_change_item(scene, item)
