import sys

PROBLEM_STR = """(define
        (problem pacman-problem)
        (:domain pacman-domain)
        (:objects )
        (:init )
        (:goal (and )))"""

DOMAIN_STR = """(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents :action-costs)
    (:types
        celula criatura
    )
    (:predicates
        (criatura-em ?c1 - criatura ?c2 - celula)

        (direita ?c1 ?c2 - celula)
        (cima ?c1 ?c2 - celula)

        ; Identifica pra qual direção o pacman se moveu
        (pacman-moveu-direita)
        (pacman-moveu-cima)
        (pacman-moveu-esquerda)
        (pacman-moveu-baixo)

        ; Turnos das criaturas
        (turno-ativado-fantasma-vermelho)
        (turno-ativado-fantasma-verde)
        (turno-ativado-fantasma-azul)
        (turno-ativado-pacman)
        
        ; Identifica o que tem em cima da célula
        (tem-pastilha ?c - celula)
        (tem-fruta-azul ?c - celula)
        (tem-fruta-verde ?c - celula)
        (tem-fruta-vermelha ?c - celula)
        (tem-parede ?c - celula)
        (tem-celula-branca ?c - celula)
        (tem-gelo ?c - celula)
        (tem-portal ?c - celula)
        
        ; Fruta ativada
        (fruta-ativada-azul)
        (fruta-ativada-verde)
        (fruta-ativada-vermelha)

        ; Variáveis do vermelho
        (vermelho-cima)
        (contador-troca-cima)
        (vermelho-baixo)
        (contador-troca-baixo)
        (vermelho-direita)
        (contador-troca-direita)
        (vermelho-esquerda)
        (contador-troca-esquerda)

        ; Condição de morte das criaturas
        (morto ?c - criatura)
    )
    
    (:functions 
        (total-cost - number)
    )
    
    (:constants 
        pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura
    )

    ;actions_here

)"""


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
    portais = [[], []]
    current_group = 0

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
                
                # Pegando as células adjacentes

                # Cima
                k = i - 1
                if k >= 0:
                    portais[current_group].append(get_name(k, j))
                else:
                    portais[current_group].append(None)
                
                # Direita
                k = j + 1
                if k < len(board[0]):
                    portais[current_group].append(get_name(k, j))
                else:
                    portais[current_group].append(None)

                # Baixo
                k = i + 1
                if k < len(board):
                    portais[current_group].append(get_name(k, j))
                else:
                    portais[current_group].append(None)

                # Esquerda
                k = j - 1
                if k >= 0:
                    portais[current_group].append(get_name(k, j))
                else:
                    portais[current_group].append(None)

                portais[current_group].append(current_cell)
                current_group += 1

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

    # Conectando as células de portal
    if portais[0][0]:
        init += f"(cima {portais[1][4]} {portais[0][0]})\n"

    if portais[0][1]:
        init += f"(direita {portais[1][4]} {portais[0][1]})\n"

    if portais[0][2]:
        init += f"(cima {portais[0][2]} {portais[1][4]})\n"

    if portais[0][3]:
        init += f"(direita {portais[0][3]} {portais[1][4]} )\n"

    if portais[1][0]:
        init += f"(cima {portais[0][4]} {portais[0][0]})\n"

    if portais[1][1]:
        init += f"(direita {portais[0][4]} {portais[0][1]})\n"

    if portais[1][2]:
        init += f"(cima {portais[0][2]} {portais[0][4]})\n"

    if portais[1][3]:
        init += f"(direita {portais[0][3]} {portais[0][4]} )\n"


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


def write_domain(my_board: list):

    for i in range(len(board)):
        for j in range(len(board[0])):
            pass
    return 


if __name__ == "__main__":

    my_board = make_board()
    write_problem(my_board)
