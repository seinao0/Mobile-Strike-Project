extends Node

var player_health = 100
var target_health = 100
var is_round_active = false

func _ready():
    # Conecta o Game Manager ao mundo do jogo (SceneTree)
    start_round()

func start_round():
    player_health = 100
    target_health = 100
    is_round_active = true
    print("Round Started! Player Health: %d, Target Health: %d" % [player_health, target_health])
    # Em um jogo real, aqui resetaríamos posições e armas.

func end_round(winner):
    is_round_active = false
    print("Round Ended! Winner: " + winner)
    # Aguarda 5 segundos antes de reiniciar o round para testes
    get_tree().create_timer(5.0).timeout.connect(start_round)

func apply_damage(target, damage):
    if not is_round_active:
        return

    if target == "player":
        player_health -= damage
        print("Player took %d damage. Remaining Health: %d" % [damage, player_health])
        if player_health <= 0:
            end_round("Target")
    elif target == "target":
        target_health -= damage
        print("Target took %d damage. Remaining Health: %d" % [damage, target_health])
        if target_health <= 0:
            end_round("Player")

func get_target_health():
    return target_health

func get_player_health():
    return player_health
