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
        (turno-fantasma-vermelho)

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

            (criatura-em pacman ?c1)

            (or 
                (criatura-em fantasma-vermelho ?c1) 
                (criatura-em fantasma-azul ?c1) 
                (criatura-em fantasma-verde ?c1) 
            )

        )

        :effect (and 

            ; Morte do azul
            (when 
                (and 
                    (fruta-azul) 
                    (criatura-em fantasma-azul ?c1)
                ) 
                
                (and
                    (morte fantasma-azul)
                    (not (criatura-em fantasma-azul ?c1))
                )
                
            )

            ; Morte do verde
            (when 
                (and 
                    (fruta-verde) 
                    (criatura-em fantasma-verde ?c1)
                ) 
                
                (and
                    (morte fantasma-verde)
                    (not (criatura-em fantasma-verde ?c1))
                )
                
            )

            ; Morte do vermelho
            (when 
                (and 
                    (fruta-vermelho) 
                    (criatura-em fantasma-vermelho ?c1)
                ) 
                
                (and
                    (morte fantasma-vermelho)
                    (not (criatura-em fantasma-vermelho ?c1))
                )
                
            )

            ; Mortes do pacman
            (when 
                (and 
                    (not (fruta-vermelho))
                    (criatura-em fantasma-vermelho ?c1)
                )

                (and
                    (morte pacman)
                    (not (criatura-em pacman ?c1))
                )
                
            )

            (when 
                (and 
                    (not (fruta-verde))
                    (criatura-em fantasma-verde ?c1)
                ) 
                
                (and
                    (morte pacman)
                    (not (criatura-em pacman ?c1))
                )
                
            )

            (when 
                (and 
                    (not (fruta-azul))
                    (criatura-em fantasma-azul ?c1)
                ) 
                
                (and
                    (morte pacman)
                    (not (criatura-em pacman ?c1))
                )
                
            )
        )
    )

    ; MOVIMENTAÇÃO PACMAN

    ; Direita
    (:action DIREITA-E
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-direita ?c1 ?c2)
            (criatura-em pacman ?c1)
            (not (eh-parede ?c2))

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-direita)
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-cima))
            (not (pacman-moveu-esquerda))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )


            ; Ativação das frutas
            (when 
                (eh-fruta-vermelho ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-verde))
                    (not (eh-fruta-vermelho ?c2))
                    (fruta-vermelho)
                )
            )

            (when 
                (eh-fruta-verde ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-vermelho))
                    (not (eh-fruta-verde ?c2))
                    (fruta-verde)
                )
            )

            (when 
                (eh-fruta-azul ?c2) 
                
                (and 
                    (not(fruta-vermelho)) 
                    (not(fruta-verde))
                    (not (eh-fruta-azul ?c2))
                    (fruta-azul)
                )
            )
        )
    )

    ; Esquerda
    (:action ESQUERDA-W
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-esquerda ?c1 ?c2)
            (criatura-em pacman ?c1)
            (not (eh-parede ?c2))
        
            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-esquerda)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-cima))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )

            ; Ativação das frutas
            (when 
                (eh-fruta-vermelho ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-verde))
                    (not (eh-fruta-vermelho ?c2))
                    (fruta-vermelho)
                )
            )

            (when 
                (eh-fruta-verde ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-vermelho))
                    (not (eh-fruta-verde ?c2))
                    (fruta-verde)
                )
            )

            (when 
                (eh-fruta-azul ?c2) 
                
                (and 
                    (not(fruta-vermelho)) 
                    (not(fruta-verde))
                    (not (eh-fruta-azul ?c2))
                    (fruta-azul)
                )
            )
        )
    )    

    ; Cima
    (:action CIMA-N
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-cima ?c1 ?c2)
            (criatura-em pacman ?c1)
            (not (eh-parede ?c2))

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-cima)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-esquerda))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )

            ; Ativação das frutas
            (when 
                (eh-fruta-vermelho ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-verde))
                    (not (eh-fruta-vermelho ?c2))
                    (fruta-vermelho)
                )
            )

            (when 
                (eh-fruta-verde ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-vermelho))
                    (not (eh-fruta-verde ?c2))
                    (fruta-verde)
                )
            )

            (when 
                (eh-fruta-azul ?c2) 
                
                (and 
                    (not(fruta-vermelho)) 
                    (not(fruta-verde))
                    (not (eh-fruta-azul ?c2))
                    (fruta-azul)
                )
            )
        )
    )

    ; Baixo
    (:action BAIXO-S
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-baixo ?c1 ?c2)
            (criatura-em pacman ?c1)
            (not (eh-parede ?c2))

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?c2)
            (pacman-moveu-baixo)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-esquerda))
            (not (pacman-moveu-cima))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )

            ; Ativação das frutas
            (when 
                (eh-fruta-vermelho ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-verde))
                    (not (eh-fruta-vermelho ?c2))
                    (fruta-vermelho)
                )
            )

            (when 
                (eh-fruta-verde ?c2) 
                
                (and 
                    (not(fruta-azul)) 
                    (not(fruta-vermelho))
                    (not (eh-fruta-verde ?c2))
                    (fruta-verde)
                )
            )

            (when 
                (eh-fruta-azul ?c2) 
                
                (and 
                    (not(fruta-vermelho)) 
                    (not(fruta-verde))
                    (not (eh-fruta-azul ?c2))
                    (fruta-azul)
                )
            )
        )
    )

    ; DUMMY MOVE

    ; Direita
    (:action DM-E
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-direita ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-parede ?c2)

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (pacman-moveu-direita)
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-cima))
            (not (pacman-moveu-esquerda))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )
        )
    )

    ; Esquerda
    (:action DM-W
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-esquerda ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-parede ?c2)
        
            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))

        )
        :effect (and            
            (pacman-moveu-esquerda)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-cima))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )
        )
    )    

    ; Cima
    (:action DM-N
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-cima ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-parede ?c2)

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (pacman-moveu-cima)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-baixo))
            (not (pacman-moveu-esquerda))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )
        )
    )

    ; Baixo
    (:action BAIXO-S
        :parameters (?c1 ?c2 - celula)
        
        :precondition (and 
            (turno-pacman)
            (celula-baixo ?c1 ?c2)
            (criatura-em pacman ?c1)
            (eh-parede ?c2)

            ; Nenhum fantasma pode estar na mesma célula que o pac
            (not (criatura-em fantasma-azul ?c1))
            (not (criatura-em fantasma-verde ?c1))
            (not (criatura-em fantasma-vermelho ?c1))
        )
        :effect (and            
            (pacman-moveu-baixo)
            (not (pacman-moveu-direita))
            (not (pacman-moveu-esquerda))
            (not (pacman-moveu-cima))

            ; Passagem de turnos
            (when 
                (not (morte fantasma-azul)) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-azul)
                )
            )

            (when 
                (and (morte fantasma-azul) (not (morte fantasma-verde))) 
                (and 
                    (not (turno-pacman)) 
                    (turno-fantasma-verde)
                )
            )

            (when 
                (and (morte fantasma-azul) (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (and 
                    (not (turno-pacman))
                    (turno-fantasma-vermelho)
                )
            )
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
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )
        
        :effect (and 
            (not (criatura-em fantasma-azul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-ESQUERDA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-direita)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-azul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-CIMA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-azul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-BAIXO
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-azul ?c1))
            (not (turno-fantasma-azul))
            (criatura-em fantasma-azul ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    ; DUMMY MOVE

    (:action AZUL-DIREITA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-esquerda)
            (celula-direita ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )
        
        :effect (and 
            (not (turno-fantasma-azul))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-ESQUERDA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-direita)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-azul))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-CIMA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-azul))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
        )
    )

    (:action AZUL-BAIXO-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-azul ?c1)
            (turno-fantasma-azul)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-azul))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-verde)) 
                (turno-fantasma-verde)
            )

            (when 
                (and (morte fantasma-verde) (not (morte fantasma-vermelho))) 
                (turno-fantasma-vermelho)
            )

            (when 
                (and (morte fantasma-verde) (morte fantasma-vermelho))
                (turno-pacman)
            )
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
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )
        
        :effect (and 
            (not (criatura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-ESQUERDA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-esquerda)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-CIMA
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-BAIXO
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (not (eh-parede ?c2))

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (criatura-em fantasma-verde ?c1))
            (not (turno-fantasma-verde))
            (criatura-em fantasma-verde ?c2)

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    ; DUMMY MOVE

    (:action VERDE-DIREITA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-direita)
            (celula-direita ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )
        
        :effect (and 
            (not (turno-fantasma-verde))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-ESQUERDA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-esquerda)
            (celula-esquerda ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-verde))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-CIMA-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-cima)
            (celula-cima ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-verde))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    (:action VERDE-BAIXO-DM
        :parameters (?c1 ?c2 - celula)

        :precondition (and 
            (pacman-moveu-baixo)
            (celula-baixo ?c1 ?c2)
            (criatura-em fantasma-verde ?c1)
            (turno-fantasma-verde)
            (eh-parede ?c2)

            (not (criatura-em pacman ?c1))
        )

        :effect (and 
            (not (turno-fantasma-verde))

            ; Passagem de turnos

            (when 
                (not (morte fantasma-vermelho))
                (turno-fantasma-vermelho)
            )

            (when 
                (morte fantasma-vermelho)
                (turno-pacman)
            )
        )
    )

    ; MOVIMENTAÇÃO DO FANTASMA-VERMELHO
    

)