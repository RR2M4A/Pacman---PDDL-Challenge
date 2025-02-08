(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions)
    (:types
        celula
    )
    (:predicates
        (criatura-em ?c1 - criatura ?c2 - celula)

        (turno-ativado ?c - criatura)
        (eh-parede ?c - celula)

        (direita ?c1 ?c2)  ;Indentifica se uma célula está à direita de outra
        (cima ?c1 ?c2)     ;Indentifica se uma célula está acima de outra

        ; Identifica pra qual direção o pacman se moveu
        (pacman-moveu-direita)
        (pacman-moveu-cima)
        (pacman-moveu-esquerda)
        (pacman-moveu-baixo)
    )
    
    (:constants 
        pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura
    )
    
    (:action mover-pacman-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado fantasma-azul)
            (not (turno-ativado pacman))

            (when (not (eh-parede ?direita-de-c1)) 
                (and 
                    (not (criatura-em pacman ?c1))
                    (criatura-em pacman ?direita-de-c1)
                )
            )
        )
    )
    
    (:action mover-pacman-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1) 
        )
        
        :effect (and

            (not (turno-ativado pacman))
            (pacman-moveu-esquerda)
            (turno-ativado fantasma-azul) ; Passa o turno pro azul

            (when (not (eh-parede ?esquerda-de-c1)) 
                (and 
                    (not (criatura-em pacman ?c1))
                    (criatura-em pacman ?esquerda-de-c1)
                )
            )
        )
    )
    
    (:action mover-pacman-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
        )
        
        :effect (and
            (not (turno-ativado pacman))
            (pacman-moveu-cima)
            (turno-ativado fantasma-azul) ; Passa o turno pro azul

            (when (not (eh-parede ?cima-de-c1)) 
                (and 
                    (not (criatura-em pacman ?c1))
                    (criatura-em pacman ?cima-de-c1)
                )
            )
        )
    )
    
    (:action mover-pacman-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (not (eh-parede ?baixo-de-c1))
        )
        
        :effect (and
            (not (turno-ativado pacman))
            (pacman-moveu-baixo)
            (turno-ativado fantasma-azul) ; Passa o turno pro azul

            (when (not (eh-parede ?baixo-de-c1)) 
                (and 
                    (not (criatura-em pacman ?c1))
                    (criatura-em pacman ?baixo-de-c1)
                )
            )
        )
    )

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (:action mover-fantasma-azul-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-esquerda)
        )
        
        :effect (and
            (not (turno-ativado fantasma-azul))
            (turno-ativado fantasma-verde) ; Passa o turno pro verde

            (when (not (eh-parede ?direita-de-c1)) 
                (and 
                    (not (criatura-em fantasma-azul ?c1))
                    (criatura-em fantasma-azul ?direita-de-c1)
                )
            )
        )
    )
    
    (:action mover-fantasma-azul-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-direita)
        )
        
        :effect (and
            (not (turno-ativado fantasma-azul))
            (turno-ativado fantasma-verde) ; Passa o turno pro verde

            (when (not (eh-parede ?esquerda-de-c1)) 
                (and 
                    (not (criatura-em fantasma-azul ?c1))
                    (criatura-em fantasma-azul ?esquerda-de-c1)
                )
            )

        )
    )
    
    (:action mover-fantasma-azul-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-baixo)
        )
        
        :effect (and
            (not (turno-ativado fantasma-azul))
            (turno-ativado fantasma-verde) ; Passa o turno pro verde

            (when (not (eh-parede ?cima-de-c1)) 
                (and 
                    (not (criatura-em fantasma-azul ?c1))
                    (criatura-em fantasma-azul ?cima-de-c1)
                )
            )
        )
    )
    
    (:action mover-fantasma-azul-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-cima)
        )
        
        :effect (and
            (not (turno-ativado fantasma-azul))
            (turno-ativado fantasma-verde) ; Passa o turno pro verde

            (when (not (eh-parede ?baixo-de-c1)) 
                (and 
                    (not (criatura-em fantasma-azul ?c1))
                    (criatura-em fantasma-azul ?baixo-de-c1)
                )
            )
        )
    )

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (:action mover-fantasma-verde-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-direita)
        )
        
        :effect (and
            (not (turno-ativado fantasma-verde))
            (turno-ativado fantasma-vermelho) ; Passa o turno pro vermelho

            (when (not (eh-parede ?direita-de-c1)) 
                (and 
                    (not (criatura-em fantasma-verde ?c1))
                    (criatura-em fantasma-verde ?direita-de-c1)
                )
            )
        )
    )
    
    (:action mover-fantasma-verde-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-esquerda)
        )
        
        :effect (and
            (not (turno-ativado fantasma-verde))
            (turno-ativado fantasma-vermelho) ; Passa o turno pro vermelho

            (when (not (eh-parede ?esquerda-de-c1)) 
                (and 
                    (not (criatura-em fantasma-verde ?c1))
                    (criatura-em fantasma-verde ?esquerda-de-c1)
                )
            )
        )
    )
    
    (:action mover-fantasma-verde-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-cima)
        )
        
        :effect (and
            (not (turno-ativado fantasma-verde))
            (turno-ativado fantasma-vermelho) ; Passa o turno pro vermelho

            (when (not (eh-parede ?cima-de-c1)) 
                (and 
                    (not (criatura-em fantasma-verde ?c1))
                    (criatura-em fantasma-verde ?cima-de-c1)
                )
            )
        )
    )
    
    (:action mover-fantasma-verde-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-baixo)
        )
        
        :effect (and
            (not (turno-ativado fantasma-verde))
            (turno-ativado fantasma-vermelho) ; Passa o turno pro vermelho

            (when (not (eh-parede ?baixo-de-c1)) 
                (and 
                    (not (criatura-em fantasma-verde ?c1))
                    (criatura-em fantasma-verde ?baixo-de-c1)
                )
            )
        )
    )
)