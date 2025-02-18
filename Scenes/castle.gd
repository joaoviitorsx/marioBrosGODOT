extends StaticBody2D

class_name Castle

@export var next_scene_path: String  # Caminho da próxima cena (para a próxima fase)
@export var is_final_castle: bool = false  # Define se este é o castelo final para terminar o jogo

# Função chamada quando o Mario entra na área de colisão
func _on_castle_area_body_entered(body):
	# Verifica se o corpo que entrou na área é o jogador
	if body is Player:
		if is_final_castle:
			show_victory_screen()  # Finaliza o jogo
		else:
			switch_scene()  # Troca para a próxima fase

# Função para trocar de cena
func switch_scene():
	if next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("Erro: Caminho da próxima cena não especificado")

# Função para mostrar a tela de vitória e finalizar o jogo
func show_victory_screen():
	# Aqui você pode carregar uma cena de vitória ou exibir algo na tela
	get_tree().change_scene_to_file("res://Scenes/victory.tscn")  # Caminho para a cena de vitória
