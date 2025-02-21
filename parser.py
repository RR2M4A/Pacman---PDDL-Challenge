import sys
import os

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
        line = line.replace("\n", "")
        board.append(line)

    return board


def get_name(line: str, col: str) -> str:

    """Função para padronizar os nomes de cada célula da grid."""

    return f"p_{line}_{col}"


def write_problem(board: list):

    objs = write_objs(board)
    init = write_init(board)
    goal = write_goal(board)

    new_problem_str = PROBLEM_STR.replace("objects", f"objects \n{objs}")
    new_problem_str = new_problem_str.replace("init", f"init \n{init}")
    new_problem_str = new_problem_str.replace("and", f"and \n{goal}")

    with open("problem.pddl", "w") as problem_file:
        problem_file.write(new_problem_str)


def write_objs(board: list) -> str:
    
    """Função responsável por escrever o :objects do arquivo de problema."""

    objs = ""
    for i in range(len(board)):
        for j in range(len(board[0])):
            objs += f"{get_name(i, j)} "

    objs += "- celula\n"
    return objs


def write_init(board: list) -> str:
    
    """Função responsável por escrever o :init do arquivo de problema."""

    init = ""
    direita = ""
    esquerda = ""
    cima = ""
    baixo = ""

    for i in range(len(board)):
        for j in range(len(board[0])):

            current_cell = get_name(i, j)

            # ADJACÊNCIAS

            # Verifica a célula à direita
            k = j + 1
            if k < len(board[0]):
                direita += (f"(celula-direita {current_cell} {get_name(i, k)})\n")
            
            # Verificando a célula abaixo
            k = i + 1
            if k < len(board):
                baixo += (f"(celula-baixo {current_cell} {get_name(k, j)})\n")

            # Verificando a célula à esquerda
            k = j - 1
            if k >= 0:
                esquerda += (f"(celula-esquerda {current_cell} {get_name(i, k)})\n")

            # Verificando a célula acima
            k = i - 1
            if k >= 0:
                cima += (f"(celula-cima {current_cell} {get_name(k, j)})\n")

            # SPAWN
            
            if board[i][j] == " ":
                init += f"(eh-chao {current_cell})\n"
            elif board[i][j] == "#":
                init += f"(eh-parede {current_cell})\n"
            elif board[i][j] == "P":
                init += f"(criatura-em pacman {current_cell})\n"
            elif board[i][j] == "R":
                init += f"(criatura-em fantasma-vermelho {current_cell})\n"
            elif board[i][j] == "B":
                init += f"(criatura-em fantasma-azul {current_cell})\n"
            elif board[i][j] == "G":
                init += f"(criatura-em fantasma-verde {current_cell})\n"


    init += "(turno-pacman)\n" + direita + baixo + esquerda + cima
    return init


def write_goal(board: list) -> str:
    return "(criatura-em pacman p_1_1)\n"

if __name__ == "__main__":

    my_board = make_board()
    write_problem(my_board)
    os.system("./planners/madagascar/Mp -o plan.txt -S 1 domain.pddl problem.pddl")
