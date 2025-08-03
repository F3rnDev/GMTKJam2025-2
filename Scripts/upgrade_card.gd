extends Panel

@export var data:CardData

var cardPrice = 0
var cardLevel = 0

func _ready() -> void:
	modulate.a = 0.5
	theme = data.theme
	$Margin/Content/Title.text = data.title
	$Margin/Content/Icon.texture = data.image
	$Margin/Content/Description.text = data.description
	
	setLevelCardTxt()
	setCardPrice()

func setCardPrice():
	cardPrice = roundi(data.cost * (1.05 ** (cardLevel-1)))
	$Margin/Content/HBoxContainer/Cost.text = str(cardPrice)

func _on_interaction_mouse_entered() -> void:
	if PlayerStats.coinAmount >= cardPrice:
		modulate.a = 1.0
		$Audio/Move.play()

func _on_interaction_mouse_exited() -> void:
	modulate.a = 0.5

func _on_interaction_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		if PlayerStats.coinAmount >= cardPrice:
			PlayerStats.updateCoinAmount(PlayerStats.coinAmount - data.cost)
			addUpgrade()

func addUpgrade():
	$Audio/Accept.play()
	match data.upgradeType:
		"Health":
			var upgradedHealth = PlayerStats.health+1
			PlayerStats.updateHealth(upgradedHealth)
		"AtkSpeed":
			var upgradedSpeed = PlayerStats.attackSpeed+1
			PlayerStats.updateAttackSpeed(upgradedSpeed)
		"Loot":
			var upgradedLoot = PlayerStats.loot+1
			PlayerStats.updateLoot(upgradedLoot)
	
	setLevelCardTxt()
	setCardPrice()

func setLevelCardTxt():
	match data.upgradeType:
		"Health":
			$Margin/Content/Level.text = "Level " + str(PlayerStats.health) + "\n"
			cardLevel = PlayerStats.health
		"AtkSpeed":
			$Margin/Content/Level.text = "Level " + str(PlayerStats.attackSpeed) + "\n"
			cardLevel = PlayerStats.attackSpeed
		"Loot":
			$Margin/Content/Level.text = "Level " + str(PlayerStats.loot) + "\n"
			cardLevel = PlayerStats.loot
