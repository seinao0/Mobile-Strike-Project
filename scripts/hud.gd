extends Control

@onready var health_label = $HealthPanel/HealthValue
@onready var ammo_label = $AmmoPanel/AmmoValue
@onready var reload_button = $ReloadButton

var game_manager = null
var gun = null

func _ready():
    # Encontra o Game Manager e a Gun (simulando a conexão)
    game_manager = get_tree().get_first_node_in_group("game_manager")
    # Em um projeto real, a Gun seria um filho do Player, mas para o protótipo, vamos simular.
    # Assumindo que a Gun está em algum lugar acessível.
    # Como não temos a cena do Player, vamos simular a conexão com a Gun.
    # Para este protótipo, vamos usar o Game Manager para obter a vida.
    
    # Conecta o botão de recarga
    reload_button.pressed.connect(_on_reload_button_pressed)
    
    # Inicia o timer de atualização
    set_process(true)

func _process(delta):
    update_hud()

func update_hud():
    if game_manager:
        health_label.text = str(game_manager.get_player_health())
    
    # Simulação da munição (assumindo que a Gun está no Game Manager para simplificar)
    # Em um projeto real, buscaríamos a Gun do Player.
    if game_manager and game_manager.has_method("get_gun"):
        gun = game_manager.get_gun()
        if gun:
            ammo_label.text = "%d / %d" % [gun.get_current_ammo(), gun.get_max_ammo()]
            reload_button.disabled = gun.is_reloading or gun.get_current_ammo() == gun.get_max_ammo()
    else:
        # Se não houver Gun, mostra apenas a vida e munição fixa para o protótipo
        ammo_label.text = "12 / 12"
        reload_button.disabled = false

func _on_reload_button_pressed():
    if gun and not gun.is_reloading:
        gun.reload()
    elif game_manager and game_manager.has_method("get_gun"):
        # Se a Gun não foi encontrada no _ready, tenta encontrar agora (simulação)
        gun = game_manager.get_gun()
        if gun and not gun.is_reloading:
            gun.reload()
