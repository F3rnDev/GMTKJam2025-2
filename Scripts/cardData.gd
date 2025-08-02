extends Resource

class_name CardData

@export_group("Card Info")
@export var theme:Theme
@export_multiline var title:String = "genericCard"
@export var image:Texture
@export_multiline var description:String = "genericDescription"

@export_group("Card Values")
@export var cost:int
@export_enum("Health", "AtkSpeed", "Loot") var upgradeType = "Health"
