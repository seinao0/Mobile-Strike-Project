extends Node3D

# Este script simula a aplicação de texturas e a criação de um mapa
# Em um projeto Godot real, isso seria feito diretamente no editor de cenas.

@export var wall_texture_path = "res://assets/textures/concrete_wall/albedo.jpg"
@export var floor_texture_path = "res://assets/textures/asphalt_floor/albedo.jpg"

func _ready():
    print("Initializing Map: Applying textures and adding props.")
    
    # 1. Simulação de Aplicação de Texturas
    # No editor, aplicaríamos wall_texture_path aos materiais das paredes
    # e floor_texture_path aos materiais do chão.
    print("Texture applied to walls: %s" % wall_texture_path)
    print("Texture applied to floor: %s" % floor_texture_path)
    
    # 2. Simulação de Adição de Props (Objetos de Cenário)
    # Adicionando um objeto de cobertura (caixa)
    add_prop("Box_Cover_A", Vector3(5, 0.5, 5))
    add_prop("Barrel_Explosive", Vector3(-5, 0.5, -5))

func add_prop(name, position):
    # Em um projeto real, instanciaríamos um MeshInstance3D com um modelo 3D
    # e o posicionaríamos.
    print("Prop added: %s at position %s" % [name, position])
