(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents :action-costs)
    (:types
        celula
    )
    (:predicates
        (criatura-em ?c1 - criatura ?c2 - celula)
        (turno-ativado ?c - criatura)

        (direita ?c1 ?c2)  ;Indentifica se uma célula está à direita de outra
        (cima ?c1 ?c2)     ;Indentifica se uma célula está acima de outra

        ; Identifica pra qual direção o pacman se moveu
        (pacman-moveu-direita)
        (pacman-moveu-cima)
        (pacman-moveu-esquerda)
        (pacman-moveu-baixo)
        
        ; Identifica o que tem em cima da célula
        (tem-pastilha ?c - celula)
        (tem-fruta-azul ?c - celula)
        (tem-fruta-verde ?c - celula)
        (tem-fruta-vermelha ?c - celula)
        (tem-parede ?c - celula)
        
        ; Fruta ativada
        (fruta-ativada-azul)
        (fruta-ativada-verde)
        (fruta-ativada-vermelha)
    )
    
    (:functions 
        (total-cost - number)
    )
    
    (:constants 
        pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura
    )
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
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
            
            
            ;Pastilha sem fruta ativada
            (when 
                (and 
                    (tem-pastilha ?direita-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?direita-de-c1)
                (not (tem-pastilha ?direita-de-c1))
                (increase (total-cost) 1)
            )
            
            ;Pastilha com fruta ativada
            (when 
                (and 
                    (tem-pastilha ?direita-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?direita-de-c1)
                (not (tem-pastilha ?direita-de-c1))
                (increase (total-cost) 4)
            )
            
            ;Dummy move com fruta ativada
            (when 
                (and 
                    (tem-parede ?direita-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (increase (total-cost) 8)
            )
            
            ;Dummy move sem fruta ativada
            (when 
                (and 
                    (tem-parede ?direita-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (increase (total-cost) 4)
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
            
            ;Pastilha sem fruta ativada
            (when 
                (and 
                    (tem-pastilha ?esquerda-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?esquerda-de-c1)
                (not (tem-pastilha ?esquerda-de-c1))
                (increase (total-cost) 1)
            )
            
            ;Pastilha com fruta ativada
            (when 
                (and 
                    (tem-pastilha ?esquerda-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?esquerda-de-c1)
                (not (tem-pastilha ?esquerda-de-c1))
                (increase (total-cost) 4)
            )
            
            ;Dummy move com fruta ativada
            (when 
                (and 
                    (tem-parede ?esquerda-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (increase (total-cost) 8)
            )
            
            ;Dummy move sem fruta ativada
            (when 
                (and 
                    (tem-parede ?esquerda-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (increase (total-cost) 4)
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
            
            ;Pastilha sem fruta ativada
            (when 
                (and 
                    (tem-pastilha ?cima-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?cima-de-c1)
                (not (tem-pastilha ?cima-de-c1))
                (increase (total-cost) 1)
            )
            
            ;Pastilha com fruta ativada
            (when 
                (and 
                    (tem-pastilha ?cima-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?cima-de-c1)
                (not (tem-pastilha ?cima-de-c1))
                (increase (total-cost) 4)
            )
            
            ;Dummy move com fruta ativada
            (when 
                (and 
                    (tem-parede ?cima-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (increase (total-cost) 8)
            )
            
            ;Dummy move sem fruta ativada
            (when 
                (and 
                    (tem-parede ?cima-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (increase (total-cost) 4)
            )

        )
    )
    
    (:action mover-pacman-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (not (tem-parede ?baixo-de-c1))
        )
        
        :effect (and
            (not (turno-ativado pacman))
            (pacman-moveu-baixo)
            (turno-ativado fantasma-azul)
            
            ;Pastilha sem fruta ativada
            (when 
                (and 
                    (tem-pastilha ?baixo-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?baixo-de-c1)
                (not (tem-pastilha ?baixo-de-c1))
                (increase (total-cost) 1)
            )
            
            ;Pastilha com fruta ativada
            (when 
                (and 
                    (tem-pastilha ?baixo-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (not (criatura-em pacman ?c1))
                (criatura-em pacman ?baixo-de-c1)
                (not (tem-pastilha ?baixo-de-c1))
                (increase (total-cost) 4)
            )
            
            ;Dummy move com fruta ativada
            (when 
                (and 
                    (tem-parede ?baixo-de-c1) 
                    (or 
                        (fruta-ativada-azul) 
                        (fruta-ativada-verde) 
                        (fruta-ativada-vermelha)
                    )
                ) 
                
                (increase (total-cost) 8)
            )
            
            ;Dummy move sem fruta ativada
            (when 
                (and 
                    (tem-parede ?baixo-de-c1) 
                    (not (fruta-ativada-azul))
                    (not (fruta-ativada-verde))
                    (not (fruta-ativada-vermelha))
                ) 
                
                (increase (total-cost) 4)
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

            (when (not (tem-parede ?direita-de-c1)) 
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

            (when (not (tem-parede ?esquerda-de-c1)) 
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

            (when (not (tem-parede ?cima-de-c1)) 
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

            (when (not (tem-parede ?baixo-de-c1)) 
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

            (when (not (tem-parede ?direita-de-c1)) 
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

            (when (not (tem-parede ?esquerda-de-c1)) 
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

            (when (not (tem-parede ?cima-de-c1)) 
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

            (when (not (tem-parede ?baixo-de-c1)) 
                (and 
                    (not (criatura-em fantasma-verde ?c1))
                    (criatura-em fantasma-verde ?baixo-de-c1)
                )
            )
        )
    )
)
