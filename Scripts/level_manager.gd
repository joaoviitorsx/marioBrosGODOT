extends Node

class_name LevelManager

var points = 0
var coins = 0

@export var ui: UI
@export var player: Player

var is_second_level = false  # Variável para identificar se o jogador está no segundo nível

func _ready():
	# Recupera os pontos e moedas armazenados no SceneData
	if SceneData.points != 0:
		ui.set_score(SceneData.points)
		points = SceneData.points
	if SceneData.coins != 0:
		coins = SceneData.coins
		ui.set_coins(SceneData.coins)

	if player:
		player.points_scored.connect(on_points_scored)
		player.castle_entered.connect(on_castle_entered)  # Conecta ao sinal quando o jogador entra no castelo
	else:
		print("Erro: 'player' não encontrado.")

# Função chamada ao coletar pontos
func on_points_scored(points_scored: int):
	points += points_scored
	ui.set_score(points)

# Função chamada ao coletar moedas
func on_coin_collected():
	coins += 1
	ui.set_coins(coins)

# Função chamada quando o jogador entra no castelo
func on_castle_entered():
	# Salva o estado atual do jogador
	save_game_state()

	# Verifica se o jogador está no segundo nível
	if is_second_level:
		finish_game()  # Finaliza o jogo se o jogador estiver no segundo nível
	else:
		switch_to_secondlevel()  # Troca para o segundo nível se o jogador estiver no primeiro nível

# Função para salvar o estado do jogo
func save_game_state():
	SceneData.points = points
	SceneData.coins = coins

# Função para trocar para o segundo nível
func switch_to_secondlevel():
	is_second_level = true  # Atualiza a variável indicando que o jogador está no segundo nível
	player.switch_to_secondlevel()  # Chama a função de troca no script do Player

# Função para finalizar o jogo
func finish_game():
	ui.on_finish()  # Exibe a tela de finalização ou vitória
	player.finish()  # Chama a função finish() no script do Player
