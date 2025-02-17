(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents :action-costs)
    (:types
        celula criatura
    )
    (:predicates
        (criatura-em ?c1 - criatura ?c2 - celula)

        (direita ?c1 ?c2 - celula)  ;Indentifica se uma célula está à direita de outra
        (cima ?c1 ?c2 - celula)     ;Indentifica se uma célula está acima de outra

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
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Possibilidades de movimento:

    ; Sem fruta ativada:

    ; .Fruta-azul
    ; .Fruta-verde
    ; .Fruta-vermelha
    ; .Pastilha
    ; .Célula em branco
    ; .Parede
    ; .Portal

    ; Com fruta ativada:

    ; .Fruta-azul
    ; .Fruta-verde
    ; .Fruta-vermelha
    ; .Pastilha
    ; .Célula em branco
    ; .Parede
    ; .Portal


    ; Movimento sem fruta ativada, para pastilha
    (:action mover-pacman-direita-p
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-pastilha ?direita-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-pastilha ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (increase (total-cost) 1)
        )
    )

    (:action mover-pacman-direita-gelo
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-gelo ?direita-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (not (turno-ativado-pacman))
            (pacman-no-gelo)
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (increase (total-cost) 2)
        )
    )

    (:action mover-pacman-direita-continua-no-gelo
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-gelo ?direita-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (increase (total-cost) 2)
        )
    )

    (:action mover-pacman-direita-sai-do-gelo
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-gelo ?c1)
            (not (tem-gelo ?direita-de-c1))

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (not (pacman-no-gelo))
            (not (turno-ativado-pacman))
            (turno-ativado-fantasma-azul)
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (increase (total-cost) 2)
        )
    )


    ; Movimento sem fruta ativada, para fruta azul
    (:action mover-pacman-direita-fa
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-azul ?direita-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-azul ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-azul)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta vermelha
    (:action mover-pacman-direita-fva
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-vermelha ?direita-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-vermelha ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-vermelha)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta verde
    (:action mover-pacman-direita-fv
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-verde ?direita-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-verde ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-verde)
            (increase (total-cost) 2)
        )
    )


    ; Movimento sem fruta ativada, para célula em branco
    (:action mover-pacman-direita-cb
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-celula-branca ?direita-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para parede (dummy move)
    (:action mover-pacman-direita-dm
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-parede ?direita-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 4)
        )
    )

    ; Movimento sem fruta ativada, para pastilha
    (:action mover-pacman-esquerda-p
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-pastilha ?esquerda-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-pastilha ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (increase (total-cost) 1)
        )
    )

    ; Movimento sem fruta ativada, para fruta azul
    (:action mover-pacman-esquerda-fa
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-azul ?esquerda-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-azul ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-azul)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta vermelha
    (:action mover-pacman-esquerda-fva
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-vermelha ?esquerda-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-vermelha ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-vermelha)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta verde
    (:action mover-pacman-esquerda-fv
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-verde ?esquerda-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-verde ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-verde)
            (increase (total-cost) 2)
        )
    )


    ; Movimento sem fruta ativada, para célula em branco
    (:action mover-pacman-esquerda-cb
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-celula-branca ?esquerda-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para parede (dummy move)
    (:action mover-pacman-esquerda-dm
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-parede ?esquerda-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 4)
        )
    )

    ; Movimento sem fruta ativada, para pastilha
    (:action mover-pacman-cima-p
    
        :parameters (?c1 ?cima-de-c1 - celula)

        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-pastilha ?cima-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-pastilha ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (increase (total-cost) 1)
        )
    )

    ; Movimento sem fruta ativada, para fruta azul
    (:action mover-pacman-cima-fa
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-azul ?cima-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-azul ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-azul)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta vermelha
    (:action mover-pacman-cima-fva
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-vermelha ?cima-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-vermelha ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-vermelha)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta verde
    (:action mover-pacman-cima-fv
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-verde ?cima-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-verde ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-verde)
            (increase (total-cost) 2)
        )
    )


    ; Movimento sem fruta ativada, para célula em branco
    (:action mover-pacman-cima-cb
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-celula-branca ?cima-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para parede (dummy move)
    (:action mover-pacman-cima-dm
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-parede ?cima-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 4)
        )
    )

    ; Movimento sem fruta ativada, para pastilha
    (:action mover-pacman-baixo-p
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-pastilha ?baixo-de-c1)

            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-pastilha ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (increase (total-cost) 1)
        )
    )

    ; Movimento sem fruta ativada, para fruta azul
    (:action mover-pacman-baixo-fa
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-azul ?baixo-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-azul ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-azul)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta vermelha
    (:action mover-pacman-baixo-fva
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-vermelha ?baixo-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-vermelha ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-vermelha)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para fruta verde
    (:action mover-pacman-baixo-fv
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-verde ?baixo-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-verde ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-verde)
            (increase (total-cost) 2)
        )
    )


    ; Movimento sem fruta ativada, para célula em branco
    (:action mover-pacman-baixo-cb
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-celula-branca ?baixo-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (increase (total-cost) 2)
        )
    )

    ; Movimento sem fruta ativada, para parede (dummy move)
    (:action mover-pacman-baixo-dm
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-parede ?baixo-de-c1)
            
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (not (fruta-ativada-vermelha))
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 4)
        )
    )

    ;; Com fruta ativada

    ; Movimento com fruta ativada, para pastilha
    (:action mover-pacman-direita-fp
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-pastilha ?direita-de-c1)

            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-pastilha ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta azul
    (:action mover-pacman-direita-ffa
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-azul ?direita-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-azul ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-azul)
            (not (fruta-ativada-vermelha))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta vermelha
    (:action mover-pacman-direita-ffva
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-vermelha ?direita-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-vermelha ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-vermelha)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta verde
    (:action mover-pacman-direita-ffv
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-fruta-verde ?direita-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (tem-fruta-verde ?direita-de-c1))
            (tem-celula-branca ?direita-de-c1)
            (fruta-ativada-verde)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-vermelha))
            (increase (total-cost) 4)
        )
    )


    ; Movimento com fruta ativada, para célula em branco
    (:action mover-pacman-direita-fcb
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-celula-branca ?direita-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para parede (dummy move)
    (:action mover-pacman-direita-fdm
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
            (tem-parede ?direita-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-direita)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 8)
        )
    )

    ; Movimento com fruta ativada, para pastilha
    (:action mover-pacman-esquerda-fp
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-pastilha ?esquerda-de-c1)

            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-pastilha ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta azul
    (:action mover-pacman-esquerda-ffa
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-azul ?esquerda-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-azul ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-azul)
            (not (fruta-ativada-vermelha))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta vermelha
    (:action mover-pacman-esquerda-ffva
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-vermelha ?esquerda-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-vermelha ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-vermelha)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta verde
    (:action mover-pacman-esquerda-ffv
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-fruta-verde ?esquerda-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (tem-fruta-verde ?esquerda-de-c1))
            (tem-celula-branca ?esquerda-de-c1)
            (fruta-ativada-verde)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-vermelha))
            (increase (total-cost) 4)
        )
    )


    ; Movimento com fruta ativada, para célula em branco
    (:action mover-pacman-esquerda-fcb
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-celula-branca ?esquerda-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para parede (dummy move)
    (:action mover-pacman-esquerda-fdm
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (tem-parede ?esquerda-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-esquerda)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 8)
        )
    )

    ; Movimento com fruta ativada, para pastilha
    (:action mover-pacman-cima-fp
    
        :parameters (?c1 ?cima-de-c1 - celula)

        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-pastilha ?cima-de-c1)

            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-pastilha ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta azul
    (:action mover-pacman-cima-ffa
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-azul ?cima-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-azul ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-azul)
            (not (fruta-ativada-vermelha))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta vermelha
    (:action mover-pacman-cima-ffva
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-vermelha ?cima-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-vermelha ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-vermelha)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta verde
    (:action mover-pacman-cima-ffv
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-fruta-verde ?cima-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (tem-fruta-verde ?cima-de-c1))
            (tem-celula-branca ?cima-de-c1)
            (fruta-ativada-verde)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-vermelha))
            (increase (total-cost) 4)
        )
    )


    ; Movimento com fruta ativada, para célula em branco
    (:action mover-pacman-cima-fcb
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-celula-branca ?cima-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para parede (dummy move)
    (:action mover-pacman-cima-fdm
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
            (tem-parede ?cima-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-cima)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 8)
        )
    )

    ; Movimento com fruta ativada, para pastilha
    (:action mover-pacman-baixo-fp
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-pastilha ?baixo-de-c1)

            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-pastilha ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta azul
    (:action mover-pacman-baixo-ffa
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-azul ?baixo-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-azul ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-azul)
            (not (fruta-ativada-vermelha))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta vermelha
    (:action mover-pacman-baixo-ffva
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-vermelha ?baixo-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-vermelha ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-vermelha)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-verde))
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para fruta verde
    (:action mover-pacman-baixo-ffv
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-fruta-verde ?baixo-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (tem-fruta-verde ?baixo-de-c1))
            (tem-celula-branca ?baixo-de-c1)
            (fruta-ativada-verde)
            (not (fruta-ativada-azul))
            (not (fruta-ativada-vermelha))
            (increase (total-cost) 4)
        )
    )


    ; Movimento com fruta ativada, para célula em branco
    (:action mover-pacman-baixo-fcb
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-celula-branca ?baixo-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))

            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (increase (total-cost) 4)
        )
    )

    ; Movimento com fruta ativada, para parede (dummy move)
    (:action mover-pacman-baixo-fdm
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-pacman)
            (criatura-em pacman ?c1)
            (cima ?baixo-de-c1 ?c1)
            (tem-parede ?baixo-de-c1)
            
            (or 
                (fruta-ativada-azul) 
                (fruta-ativada-verde) 
                (fruta-ativada-vermelha)
            )
        )
        
        :effect (and

            (pacman-moveu-baixo)
            (turno-ativado-fantasma-azul)
            (not (turno-ativado-pacman))
            (increase (total-cost) 8)
        )
    )


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Possibilidades de movimento dos fantasmas:

    ; .Para a parede
    ; .Para célula em branco
    ; .Para portal

    (:action mover-fantasma-azul-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-esquerda)
            (not (tem-parede ?direita-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
            (not (criatura-em fantasma-azul ?c1))
            (criatura-em fantasma-azul ?direita-de-c1)

        )
    )
    
    (:action mover-fantasma-azul-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-direita)
            (not (tem-parede ?esquerda-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
            (not (criatura-em fantasma-azul ?c1))
            (criatura-em fantasma-azul ?esquerda-de-c1)

        )
    )
    
    (:action mover-fantasma-azul-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-baixo)
            (not (tem-parede ?cima-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
            (not (criatura-em fantasma-azul ?c1))
            (criatura-em fantasma-azul ?cima-de-c1)
        )
    )
    
    (:action mover-fantasma-azul-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-cima)
            (not (tem-parede ?baixo-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
            (not (criatura-em fantasma-azul ?c1))
            (criatura-em fantasma-azul ?baixo-de-c1)
        )
    )


    (:action mover-fantasma-azul-direita-dm
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-esquerda)
            (tem-parede ?direita-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
        )
    )
    
    (:action mover-fantasma-azul-esquerda-dm
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-direita)
            (tem-parede ?esquerda-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
        )
    )
    
    (:action mover-fantasma-azul-cima-dm
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-baixo)
            (tem-parede ?cima-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
        )
    )
    
    (:action mover-fantasma-azul-baixo-dm
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-azul)
            (criatura-em fantasma-azul ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-cima)
            (tem-parede ?baixo-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-azul))
            (turno-ativado-fantasma-verde) ; Passa o turno pro verde
        )
    )

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (:action mover-fantasma-verde-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-direita)
            (not (tem-parede ?direita-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
            (not (criatura-em fantasma-verde ?c1))
            (criatura-em fantasma-verde ?direita-de-c1)
        )
    )
    
    (:action mover-fantasma-verde-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-esquerda)
            (not (tem-parede ?esquerda-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
            (not (criatura-em fantasma-verde ?c1))
            (criatura-em fantasma-verde ?esquerda-de-c1)
        )
    )
    
    (:action mover-fantasma-verde-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-cima)
            (not (tem-parede ?cima-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
            (not (criatura-em fantasma-verde ?c1))
            (criatura-em fantasma-verde ?cima-de-c1)
        )
    )
    
    (:action mover-fantasma-verde-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-baixo)
            (not (tem-parede ?baixo-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
            (not (criatura-em fantasma-verde ?c1))
            (criatura-em fantasma-verde ?baixo-de-c1)
        )
    )

    (:action mover-fantasma-verde-direita-dm
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?c1 ?direita-de-c1)
            (pacman-moveu-direita)
            (tem-parede ?direita-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
        )
    )
    
    (:action mover-fantasma-verde-esquerda-dm
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (pacman-moveu-esquerda)
            (tem-parede ?esquerda-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
        )
    )
    
    (:action mover-fantasma-verde-cima-dm
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?c1 ?cima-de-c1)
            (pacman-moveu-cima)
            (tem-parede ?cima-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
        )
    )
    
    (:action mover-fantasma-verde-baixo-dm
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-verde)
            (criatura-em fantasma-verde ?c1)
            (cima ?baixo-de-c1 ?c1)
            (pacman-moveu-baixo)
            (tem-parede ?baixo-de-c1)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-verde))
            (turno-ativado-fantasma-vermelho) ; Passa o turno pro vermelho
        )
    )

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (:action mover-fantasma-vermelho-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (direita ?c1 ?direita-de-c1)
            (vermelho-direita)
            (not (tem-parede ?direita-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-vermelho))
            (not (criatura-em fantasma-vermelho ?c1))
            (criatura-em fantasma-vermelho ?direita-de-c1)
            (turno-ativado-pacman)

            (not (contador-troca-baixo))
            (not (contador-troca-cima))
            (not (contador-troca-direita))
            (not (contador-troca-esquerda))
        )
    )
    
    (:action mover-fantasma-vermelho-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (vermelho-esquerda)
            (not (tem-parede ?esquerda-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-vermelho))
            (not (criatura-em fantasma-vermelho ?c1))
            (criatura-em fantasma-vermelho ?esquerda-de-c1)
            (turno-ativado-pacman)

            (not (contador-troca-baixo))
            (not (contador-troca-cima))
            (not (contador-troca-direita))
            (not (contador-troca-esquerda))
        )
    )
    
    (:action mover-fantasma-vermelho-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (cima ?c1 ?cima-de-c1)
            (vermelho-cima)
            (not (tem-parede ?cima-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-vermelho))
            (not (criatura-em fantasma-vermelho ?c1))
            (criatura-em fantasma-vermelho ?cima-de-c1)
            (turno-ativado-pacman)

            (not (contador-troca-baixo))
            (not (contador-troca-cima))
            (not (contador-troca-direita))
            (not (contador-troca-esquerda))
        )
    )
    
    (:action mover-fantasma-vermelho-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (cima ?baixo-de-c1 ?c1)
            (vermelho-baixo)
            (not (tem-parede ?baixo-de-c1))
        )
        
        :effect (and
            (not (turno-ativado-fantasma-vermelho))
            (not (criatura-em fantasma-vermelho ?c1))
            (criatura-em fantasma-vermelho ?baixo-de-c1)
            (turno-ativado-pacman)

            (not (contador-troca-baixo))
            (not (contador-troca-cima))
            (not (contador-troca-direita))
            (not (contador-troca-esquerda))
        )
    )

    (:action fantasma-vermelho-dm
    
        :parameters ()
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (contador-troca-baixo)
            (contador-troca-cima)
            (contador-troca-direita)
            (contador-troca-esquerda)
        )
        
        :effect (and
            (not (turno-ativado-fantasma-vermelho))
            (turno-ativado-pacman)
        )
    )


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (:action trocar-direcao-para-baixo
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (direita ?c1 ?direita-de-c1)
            (vermelho-direita)
            (tem-parede ?direita-de-c1)
            (not (contador-troca-baixo))
        )
        
        :effect (and
            (not (vermelho-direita))
            (vermelho-baixo)
            (contador-troca-baixo)
        )
    )

    (:action trocar-direcao-para-esquerda
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (cima ?baixo-de-c1 ?c1)
            (vermelho-baixo)
            (tem-parede ?baixo-de-c1)
            (not (contador-troca-esquerda))
        )
        
        :effect (and
            (not (vermelho-baixo))
            (vermelho-esquerda)
            (contador-troca-esquerda)
        )
    )

    (:action trocar-direcao-para-cima
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (direita ?esquerda-de-c1 ?c1)
            (vermelho-esquerda)
            (tem-parede ?esquerda-de-c1)
            (not (contador-troca-cima))
        )

        :effect (and
            (not (vermelho-esquerda))
            (vermelho-cima)
            (contador-troca-cima)
        )
    )

    (:action trocar-direcao-para-direita
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado-fantasma-vermelho)
            (criatura-em fantasma-vermelho ?c1)
            (cima ?c1 ?cima-de-c1)
            (vermelho-cima)
            (tem-parede ?cima-de-c1)
            (not (contador-troca-direita))
        )
        
        :effect (and
            (not (vermelho-cima))
            (vermelho-direita)
            (contador-troca-direita)
        )
    )
)
