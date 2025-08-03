extends Node

signal healthChanged
signal attackSpdChanged
signal lootChanged
signal coinAmountChanged

var defaultHealth = 3.0
var defaultAttackSpeed = 1.0

var health = 1
var attackSpeed = 1
var loot = 1
var coinAmount = 0

func resetEverything():
	health = 1
	attackSpeed = 1
	loot = 1
	coinAmount = 0

func updateHealth(value):
	health = value
	healthChanged.emit()

func updateAttackSpeed(value):
	attackSpeed = value
	attackSpdChanged.emit()

func updateLoot(value):
	loot = value
	lootChanged.emit()

func updateCoinAmount(value):
	coinAmount = value
	coinAmountChanged.emit()
