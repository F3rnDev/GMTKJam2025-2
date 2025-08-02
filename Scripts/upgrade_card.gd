extends Panel

@export var data:CardData

func _ready() -> void:
	modulate.a = 0.5
	theme = data.theme
	$Margin/Content/Title.text = data.title
	$Margin/Content/Icon.texture = data.image
	$Margin/Content/Description.text = data.description
	$Margin/Content/HBoxContainer/Cost.text = str(data.cost)

func _on_interaction_mouse_entered() -> void:
	if PlayerStats.coinAmount >= data.cost:
		modulate.a = 1.0

func _on_interaction_mouse_exited() -> void:
	modulate.a = 0.5

func _on_interaction_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		if PlayerStats.coinAmount >= data.cost:
			PlayerStats.updateCoinAmount(PlayerStats.coinAmount - data.cost)
			addUpgrade()

func addUpgrade():
	match data.upgradeType:
		"Health":
			var upgradedHealth = PlayerStats.health*1.10
			PlayerStats.updateHealth(upgradedHealth)
		"AtkSpeed":
			var upgradedSpeed = PlayerStats.attackSpeed*0.95
			PlayerStats.updateAttackSpeed(upgradedSpeed)
		"Loot":
			var upgradedLoot = PlayerStats.loot+1
			PlayerStats.updateLoot(upgradedLoot)
