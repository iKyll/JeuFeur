extends Resource
class_name ItemData

# IMPORTANT
# Ecrire les données a l'intérieur des variables comme ici

# Stackable, Armor, Weapon
export var category: String = ""
# For Stackable: HealPotion
# For Armor: Helmet, Chestplate, Leggings, Boots
# For Weapon: Sword, Daggers, Bow, Magic Wand (2 Armes equipées simultanément)
export var type: String = ""

export var damage: int = -1
export var defense: int = -1
export var health: int = -1

export var item_name: String = ""

export var buy_price: int = -1
export var sell_price: int = -1

# Logiquement sa part
export var texture : Texture = null
export var world_texture: Texture = null
