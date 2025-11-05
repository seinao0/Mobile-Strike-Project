extends Node3D

var damage = 20
var max_ammo = 12
var current_ammo = 12
var is_reloading = false
var reload_time = 1.5 # Tempo em segundos para recarregar

func shoot():
    if is_reloading or current_ammo <= 0:
        print("Click! Cannot shoot.")
        return

    current_ammo -= 1
    print("Shot fired! Ammo left: %d" % current_ammo)
    
    # Lógica de Raycast para detectar acerto (simulando o tiro)
    # Em um projeto real, esta lógica estaria no Player ou em um script de Raycast dedicado.
    # Por enquanto, apenas simula um acerto no alvo de teste.
    
    # Se acertar o alvo de teste (simulação):
    var game_manager = get_tree().get_first_node_in_group("game_manager")
    if game_manager:
        game_manager.apply_damage("target", damage)

func reload():
    if is_reloading or current_ammo == max_ammo:
        return

    is_reloading = true
    print("Reloading...")
    
    # Simula o tempo de recarga
    get_tree().create_timer(reload_time).timeout.connect(_on_reload_finished)

func _on_reload_finished():
    current_ammo = max_ammo
    is_reloading = false
    print("Reload finished! Ammo: %d" % current_ammo)

func get_current_ammo():
    return current_ammo

func get_max_ammo():
    return max_ammo
