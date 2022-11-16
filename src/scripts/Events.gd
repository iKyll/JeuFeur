extends Node

# warnings-disable

signal spawn_item(itemData, pos)

# IN PLAYER !
# Need to link with _on_object_collected in InventoryDataManager
signal object_collected(obj)

