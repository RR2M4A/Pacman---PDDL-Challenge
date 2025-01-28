import sys

def make_board() -> list:

    """Função que recebe a grid (input) e retorna ela
    em formato de lista """

    board = []

    for line in sys.stdin:
        board.append(list(line.strip()))

    return board


def get_name(line: str, col: str) -> str:

    """Função para padronizar os nomes de cada célula da grid."""

    position_name = f"p_{line}_{col}"

    return position_name


def add_positions_info(positions_dict: dict, current_cell_name: str = '', 
                          connected_cell_name: str = '', symbol: str = ''):

    """Função única para alimentar o dicionário de células da grid com 
    informações sobre essas células, tal como presença de pastilhas,
    células adjacentes, presença de fantasmas, etc..."""

    # Inicializa a célula no dicionário, caso ela ainda não esteja nele
    if current_cell_name not in positions_dict:
        positions_dict[current_cell_name] = [set(), ""]

    # Alimentando o dicionário
    if connected_cell_name:
        positions_dict[current_cell_name][0].add(connected_cell_name)   
    if symbol:
        positions_dict[current_cell_name][1] = symbol


def get_positions_info(positions_dict: dict, board: list):

    """Função que define a adjacência das células"""
    
    for i in range(len(board)):
        for j in range(len(board[0])):

            current_symbol = board[i][j]

            if current_symbol != "#":

                current_position_name = get_name(i, j)
                add_positions_info(positions_dict, current_position_name, symbol=current_symbol)

                # Verificando células adjacentes (direita, esquerda, cima, baixo)
                # Cima
                k = i - 1
                if k >= 0:
                    if board[k][j] != "#":
                        adjacent_position_name = get_name(k, j)
                        add_positions_info(positions_dict, current_position_name, adjacent_position_name)
                
                # Baixo
                k = i + 1
                if k < len(board):
                    if board[k][j] != "#":
                        adjacent_position_name = get_name(k, j)
                        add_positions_info(positions_dict, current_position_name, adjacent_position_name)

                # Direita
                k = j + 1
                if k < len(board[0]):
                    if board[i][k] != "#":
                        adjacent_position_name = get_name(i, k)
                        add_positions_info(positions_dict, current_position_name, adjacent_position_name)

                # Esquerda
                k = j - 1
                if k >= 0:
                    if board[i][k] != "#":
                        adjacent_position_name = get_name(i, k)
                        add_positions_info(positions_dict, current_position_name, adjacent_position_name)


if __name__ == "__main__":

    my_board = make_board()
    cells_dict = {}
    get_positions_info(cells_dict, my_board)

    for key, item in cells_dict.items():
        print(key, item)