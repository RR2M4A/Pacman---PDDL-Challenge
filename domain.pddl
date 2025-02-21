(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions)
    (:types
        celula criatura
    )
    (:predicates
        
        (turno-pacman)

        (criatura-em ?c1 - criatura ?c2 - celula)
        (celula-direita ?c1 ?direita-de-c1 - celula)
        (celula-esquerda ?c1 ?esquerda-de-c1 - celula)
        (celula-cima ?c1 ?cima-de-c1 - celula)
        (celula-baixo ?c1 ?baixo-de-c1 - celula)

        ; Tipos de células
        (eh-parede ?c - celula)
        (eh-chao ?c - celula)
    )
    
    (:constants 
        pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura
    )

    ; MOVIMENTAÇÃO PACMAN

    ; Direita
    (:action DIREITA
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-direita ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-chao ?c2)
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
        )
    )

    ; Esquerda
    (:action ESQUERDA-W
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-esquerda ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-chao ?c2)
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
        )
    )

    ; Cima
    (:action CIMA-N
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-cima ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-chao ?c2)
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
        )
    )

    ; Baixo
    (:action BAIXO-S
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-baixo ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-chao ?c2)
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
        )
    )
    
)