extends Node2D

@onready var enemy = preload("res://Nodes/enemy.tscn")
var wave = 1
@export var enemyMax = 5 #changes per wave
@export var enemySpawnTime = 2.0 #changes per wave

var enemyCount = 0
var enemiesSpawned = 0
var enemyDead = 0

var roundRunning = false

func _ready() -> void:
	startWave()
	PlayerStats.healthChanged.connect(updatePlayerLife)
	PlayerStats.coinAmountChanged.connect(setPlayerMoney)

func startWave():
	$SpawnTime.wait_time = enemySpawnTime / wave
	enemyCount = enemyMax + (wave - 1) * 2
	roundRunning = true
	
	setInfoUI()

func setInfoUI():
	$"CanvasLayer/Ui/Wave Count".text = "Wave " + str(wave)
	updateEnemiesLeft()
	updatePlayerLife()
	updatePlayerMoney(0)

func updateEnemiesLeft():
	$"CanvasLayer/Ui/Enemies Left".text = "- Enemies Left -\n" + str(enemyCount-enemyDead)  + "/" + str(enemyCount)

func updatePlayerLife():
	$"CanvasLayer/Ui/LifeBar".max_value = PlayerStats.health
	$"CanvasLayer/Ui/LifeBar".value = $Player.health
	$"CanvasLayer/Ui/LifeBar/HBoxContainer/MaxLifeValue".text = str(snapped(PlayerStats.health, 0.1))
	$"CanvasLayer/Ui/LifeBar/HBoxContainer/LifeValue".text = str(snapped($Player.health, 0.1))

func updatePlayerMoney(amount):
	$Player.setMoney(amount)
	setPlayerMoney()

func setPlayerMoney():
	$"CanvasLayer/Ui/HBoxContainer/Label".text = str(PlayerStats.coinAmount)

func shake():
	$GameCamera.shakeCamera()

func SetNewWave():
	roundRunning = false
	wave += 1
	enemyDead = 0
	enemiesSpawned = 0
	
	$CanvasLayer/Upgrades.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $SpawnTime.is_stopped() and roundRunning and enemiesSpawned < enemyCount:
		spawnEnemy()
	
	if enemyDead == enemyCount and roundRunning:
		SetNewWave()

func spawnEnemy():
	enemiesSpawned += 1
	
	var enemyInstance = enemy.instantiate()
	enemyInstance.playerRef = $Player
	
	#getrandom
	var randomSpawn = randi_range(0, $Spawners.get_child_count()-1)
	var spawner = $Spawners.get_child(randomSpawn)
	
	enemyInstance.global_position = spawner.global_position
	
	add_child(enemyInstance)
	
	$SpawnTime.start()

func _on_upgrades_continue_game() -> void:
	startWave()
