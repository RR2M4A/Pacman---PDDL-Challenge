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

if __name__ == "__main__":

    my_board = make_board()
    write_problem(my_board)
