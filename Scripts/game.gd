extends Node2D

@onready var enemy = preload("res://Nodes/enemy.tscn")
var wave = 1
@export var enemyMax = 5 #changes per wave
@export var enemySpawnTime = 2.0 #changes per wave

var enemyCount = 0
var enemiesSpawned = 0
var enemyDead = 0

var roundRunning = false

var gameOver = false

var enemies = []

func _init() -> void:
	PlayerStats.resetEverything()

func _ready() -> void:
	startWave()
	PlayerStats.healthChanged.connect(updatePlayerLife)
	PlayerStats.coinAmountChanged.connect(setPlayerStats)

func startWave():
	$SpawnTime.wait_time = enemySpawnTime / wave
	enemyCount = enemyMax + (wave - 1) * 2
	roundRunning = true
	
	setInfoUI()
	Music.setMusic(Music.MusicType.Game)

func setInfoUI():
	$"CanvasLayer/Ui/Wave Count".text = "LOOP " + str(wave)
	updateEnemiesLeft()
	updatePlayerLife()
	updatePlayerMoney(0)

func updateEnemiesLeft():
	$"CanvasLayer/Ui/Enemies Left".text = "- Enemies Left -\n" + str(enemyCount-enemyDead)  + "/" + str(enemyCount)

func updatePlayerLife():
	var maxHealth = PlayerStats.defaultHealth * (1.25 ** (PlayerStats.health - 1))
	$"CanvasLayer/Ui/LifeBar".max_value = maxHealth
	$"CanvasLayer/Ui/LifeBar".value = $Player.health
	$"CanvasLayer/Ui/LifeBar/HBoxContainer/MaxLifeValue".text = str(snapped(maxHealth, 0.1))
	$"CanvasLayer/Ui/LifeBar/HBoxContainer/LifeValue".text = str(snapped($Player.health, 0.1))

func updatePlayerMoney(amount):
	$Player.setMoney(amount)
	setPlayerStats()

func setPlayerStats():
	$"CanvasLayer/Ui/HBoxContainer/Label".text = str(PlayerStats.coinAmount)
	$"CanvasLayer/Ui/LootContainer/Label".text = "Lvl " + str(PlayerStats.loot)
	var attackSpeed = PlayerStats.defaultAttackSpeed * (0.95 ** (PlayerStats.attackSpeed - 1))
	$"CanvasLayer/Ui/SwordContainer/Label".text = str(snapped(attackSpeed, 0.01))

func shake():
	$GameCamera.shakeCamera()

func SetNewWave():
	roundRunning = false
	wave += 1
	enemyDead = 0
	enemiesSpawned = 0
	
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	
	enemies.clear()
	
	$CanvasLayer/Upgrades.visible = true
	$CanvasLayer/Upgrades/AnimationPlayer.play("Appear")
	Music.setMusic(Music.MusicType.Menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $SpawnTime.is_stopped() and roundRunning and enemiesSpawned < enemyCount:
		spawnEnemy()
	
	if enemyDead == enemyCount and roundRunning:
		SetNewWave()
	
	if gameOver and Input.is_action_just_pressed("Reload"):
		Transition.transitionToScene("res://Nodes/game.tscn")
		Music.isGameOver = false
	
	if gameOver and !$CanvasLayer/Label/AnimationPlayer.is_playing():
		$CanvasLayer/Label/AnimationPlayer.play("idle")
		$CanvasLayer/PauseMenu.gameOver = true

func spawnEnemy():
	enemiesSpawned += 1
	
	var enemyInstance = enemy.instantiate()
	enemyInstance.playerRef = $Player
	
	#getrandom
	var randomSpawn = randi_range(0, $Spawners.get_child_count()-1)
	var spawner = $Spawners.get_child(randomSpawn)
	
	enemyInstance.global_position = spawner.global_position
	
	add_child(enemyInstance)
	enemies.append(enemyInstance)
	
	$SpawnTime.start()

func _on_upgrades_continue_game() -> void:
	startWave()
