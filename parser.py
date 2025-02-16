import sys

PROBLEM_STR = """(define
        (problem pacman-problem)
        (:domain pacman-domain)
        (:objects )
        (:init )
        (:goal (and )))"""


def make_board() -> list:

    """Função que recebe a grid (input) e retorna ela
    em formato de lista """

    board = []

    for line in sys.stdin:
        board.append(list(line.strip()))

    return board


def get_name(line: str, col: str) -> str:

    """Função para padronizar os nomes de cada célula da grid."""

    return f"p_{line}_{col}"


def write_objs(board: list) -> str:
    
    """Função responsável por escrever o :objects do arquivo de problema."""

    objs = ""
    for i in range(len(board)):
        for j in range(len(board)):
            objs += f"{get_name(i, j)} "

    objs += "- celula\n"
    return objs


def write_init(board: list) -> str:
    
    """Função responsável por escrever o :init do arquivo de problema."""

    init = ""
    direita = ""
    cima = ""

    for i in range(len(board)):
        for j in range(len(board[0])):

            current_cell = get_name(i, j)

            # ADJACÊNCIAS

            # Verifica a célula à direita
            k = j + 1
            if k < len(board[0]):
                direita += f"(direita {current_cell} {get_name(i, k)})\n"
            
            # Verificando a célula abaixo
            k = i + 1
            if k < len(board):
                cima += f"(cima {get_name(k, j)} {current_cell})\n"

            # SPAWN

            if board[i][j] == "#":
                init += f"(tem-parede {current_cell})\n"
            elif board[i][j] == "*":
                init += f"(tem-pastilha {current_cell})\n"
            elif board[i][j] == " ":
                init += f"(tem-celula-branca {current_cell})\n"
            elif board[i][j] == "I":
                init += f"(tem-gelo {current_cell})\n"
            elif board[i][j] == "O":
                init += f"(tem-portal {current_cell})\n"
            elif board[i][j] == "P":
                init += f"(criatura-em pacman {current_cell})\n"
            elif board[i][j] == "R":
                init += f"(criatura-em fantasma-vermelho {current_cell})\n"
            elif board[i][j] == "B":
                init += f"(criatura-em fantasma-azul {current_cell})\n"
            elif board[i][j] == "G":
                init += f"(criatura-em fantasma-verde {current_cell})\n"
            elif board[i][j] == "!":
                init += f"(tem-fruta-vermelha {current_cell})\n"
            elif board[i][j] == "@":
                init += f"(tem-fruta-verde {current_cell})\n"
            elif board[i][j] == "$":
                init += f"(tem-fruta-azul {current_cell})\n"

    init += "(turno-ativado-pacman)\n(vermelho-direita)\n" + direita + cima
    return init


def write_goal(board: list) -> str:

    """Função responsável por escrever o :goal do arquivo de init"""
    
    # Goal da track AGILE
    goal = "(morto fantasma-vermelho)\n(morto fantasma-azul)\n(morto-fantasma-verde)\n"
    
    return goal


def write_problem(my_board: list):

    objs = write_objs(my_board)
    init = write_init(my_board)
    goal = write_goal(my_board)

    new_problem_str = PROBLEM_STR.replace("objects", f"objects \n{objs}")
    new_problem_str = new_problem_str.replace("init", f"init \n{init}")
    new_problem_str = new_problem_str.replace("and", f"and \n{goal}")

    with open("problem.pddl", "w") as problem_file:
        problem_file.write(new_problem_str)


if __name__ == "__main__":

    my_board = make_board()
    write_problem(my_board)
