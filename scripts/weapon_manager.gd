extends Node

var weapons = []
var current_weapon_index = 0

func _ready():
    # Instancia as armas (simulação)
    var pistol = load("res://scripts/gun.gd").new()
    var rifle = load("res://scripts/assault_rifle.gd").new()
    var sniper = load("res://scripts/sniper_rifle.gd").new()
    
    weapons.append(pistol)
    weapons.append(rifle)
    weapons.append(sniper)
    
    # Define a arma inicial
    current_weapon_index = 0
    print("Initial weapon: Pistol")

func switch_weapon(index):
    if index >= 0 and index < weapons.size():
        current_weapon_index = index
        print("Switched to weapon index: %d" % index)
        # Em um jogo real, aqui faríamos a animação de troca de arma e a troca do modelo 3D.

func get_current_weapon():
    return weapons[current_weapon_index]

func get_weapon_by_index(index):
    if index >= 0 and index < weapons.size():
        return weapons[index]
    return null

func fire_current_weapon():
    get_current_weapon().shoot()

func reload_current_weapon():
    get_current_weapon().reload()
