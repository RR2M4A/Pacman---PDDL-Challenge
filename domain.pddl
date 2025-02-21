(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions)
    (:types
        celula criatura
    )
    (:predicates
        
        (morte ?c - criatura)
        (turno-pacman)
        (turno-fantasma-azul)
        (turno-fantasma-verde)

        (criatura-em ?c1 - criatura ?c2 - celula)
        (celula-direita ?c1 ?direita-de-c1 - celula)
        (celula-esquerda ?c1 ?esquerda-de-c1 - celula)
        (celula-cima ?c1 ?cima-de-c1 - celula)
        (celula-baixo ?c1 ?baixo-de-c1 - celula)

        ; Tipos de células
        (eh-parede ?c - celula)
        (eh-chao ?c - celula)
        (eh-fruta-azul ?c - celula)
        (eh-fruta-verde ?c - celula)
        (eh-fruta-vermelho ?c - celula)

        ; Ativação das frutas
        (fruta-verde)
        (fruta-azul)
        (fruta-vermelho)


        ; Movimentação do pacman
        (pacman-moveu-direita)
        (pacman-moveu-esquerda)
        (pacman-moveu-cima)
        (pacman-moveu-baixo)
    )
    
    (:constants 
        pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura
    )

    ; CHECAGEM DA MORTE

    (:action CHECAR-MORTE
        :parameters (?c1 - celula)
        :precondition (and

            (or 
                (and 
                    (criatura-em fantasma-vermelho ?c1) 
                    (criatura-em pacman ?c1)
                )

                (and 
                    (criatura-em fantasma-azul ?c1) 
                    (criatura-em pacman ?c1)
                ) 

                (and 
                    (criatura-em fantasma-verde ?c1) 
                    (criatura-em pacman ?c1)
                )
            )

        )

        :effect (and 

            ; Morte do azul
            (when 
                (and 
                    (fruta-azul) 
                    (criatura-em fantasma-azul ?c1)
                ) 
                
                (morte fantasma-azul)
            )

            ; Morte do verde
            (when 
                (and 
                    (fruta-verde) 
                    (criatura-em fantasma-verde ?c1)
                ) 
                
                (morte fantasma-verde)
            )

            ; Morte do vermelho
            (when 
                (and 
                    (fruta-vermelho) 
                    (criatura-em fantasma-vermelho ?c1)
                ) 
                
                (morte fantasma-vermelho)
            )

            ; Mortes do pacman
            (when 
                (and 
                    (not (fruta-vermelho))
                    (criatura-em fantasma-vermelho ?c1)
                ) 
                
                (morte pacman)
            )

            (when 
                (and 
                    (not (fruta-verde))
                    (criatura-em fantasma-verde ?c1)
                ) 
                
                (morte pacman)
            )

            (when 
                (and 
                    (not (fruta-azul))
                    (criatura-em fantasma-azul ?c1)
                ) 
                
                (morte pacman)
            )
        )
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

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-direita)
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
        
            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-esquerda)
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

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-cima)
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

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-baixo)
        )
    )

    ; MOVIMENTAÇÃO DO FANTASMA AZUL

    (:action AZUL-DIREITA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-esquerda)
            (celula-direita ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-chao ?c2)

            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        
        :effect (and 
            (not (critura-em fantasma-zul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)
        )
    )

    (:action AZUL-ESQUERDA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-direita)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-zul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)
        )
    )

    (:action AZUL-CIMA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-zul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)
        )
    )

    (:action AZUL-BAIXO
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-zul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)
        )
    )

    ; MOVIMENTAÇÃO DO FANTASMA VERDE

    (:action VERDE-DIREITA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-direita)
            (celula-direita ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-chao ?c2)
        )
        
        :effect (and 
            (not (critura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)
        )
    )

    (:action VERDE-ESQUERDA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-esquerda)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)
        )
    )

    (:action VERDE-CIMA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-cima ?c1)
            (turno-fantasma-verde)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)
        )
    )

    (:action VERDE-BAIXO
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-chao ?c2)
        )

        :effect (and 
            (not (critura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)
        )
    )

    ; MOVIMENTAÇÃO DO FANTASMA-VERMELHO
    

)