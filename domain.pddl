(define
    (domain pacman-domain)
    (:requirements :strips :typing :negative-preconditions)
    (:types
        celula
    )
    (:predicates
        (criatura-em ?c1 - criatura ?c2 - celula)
        (turno-ativado)
        (direita ?c1 ?c2)
        (esquerda ?c1 ?c2)
        (cima ?c1 ?c2)
        (baixo ?c1 ?c2)
    
    )
    
    (:constants pacman fantasma-verde fantasma-vermelho fantasma-azul - criatura)
    
    (:action mover-pacman-direita
    
        :parameters (?c1 ?direita-de-c1 - celula)
        
        :precondition (and
            (turno-ativado)
            (criatura-em pacman ?c1)
            (direita ?c1 ?direita-de-c1)
        )
        
        :effect (and
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?direita-de-c1)
            (not (turno-ativado))
            
            (forall (?outra-celula1 ?outra-celula2 - celula) 
                (and 
                    ; Movimento do verde
                    (when 
                        (and 
                            (direita ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-verde ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-verde ?outra-celula1))
                            (criatura-em fantasma-verde ?outra-celula2)
                        )
                    ) 
                    
                    ; Movimento do azul
                    (when 
                        (and 
                            (esquerda ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-azul ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-azul ?outra-celula1))
                            (criatura-em fantasma-azul ?outra-celula2)
                        )
                    )
                )
            )
        )
    )
    
    (:action mover-pacman-esquerda
    
        :parameters (?c1 ?esquerda-de-c1 - celula)
        
        :precondition (and
            (turno-ativado)
            (criatura-em pacman ?c1)
            (esquerda ?c1 ?esquerda-de-c1)
        )
        
        :effect (and
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?esquerda-de-c1)
            (not (turno-ativado))
            
            (forall (?outra-celula1 ?outra-celula2 - celula) 
                (and 
                    ; Movimento do verde
                    (when 
                        (and 
                            (esquerda ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-verde ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-verde ?outra-celula1))
                            (criatura-em fantasma-verde ?outra-celula2)
                        )
                    ) 
                    
                    ; Movimento do azul
                    (when 
                        (and 
                            (direita ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-azul ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-azul ?outra-celula1))
                            (criatura-em fantasma-azul ?outra-celula2)
                        )
                    )
                )
            )
        )
    )
    
    (:action mover-pacman-cima
    
        :parameters (?c1 ?cima-de-c1 - celula)
        
        :precondition (and
            (turno-ativado)
            (criatura-em pacman ?c1)
            (cima ?c1 ?cima-de-c1)
        )
        
        :effect (and
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?cima-de-c1)
            (not (turno-ativado))
            
            (forall (?outra-celula1 ?outra-celula2 - celula) 
                (and 
                    ; Movimento do verde
                    (when 
                        (and 
                            (cima ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-verde ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-verde ?outra-celula1))
                            (criatura-em fantasma-verde ?outra-celula2)
                        )
                    ) 
                    
                    ; Movimento do azul
                    (when 
                        (and 
                            (baixo ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-azul ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-azul ?outra-celula1))
                            (criatura-em fantasma-azul ?outra-celula2)
                        )
                    )
                )
            )
        )
    )
    
    (:action mover-pacman-baixo
    
        :parameters (?c1 ?baixo-de-c1 - celula)
        
        :precondition (and
            (turno-ativado)
            (criatura-em pacman ?c1)
            (baixo ?c1 ?baixo-de-c1)
        )
        
        :effect (and
            (not (criatura-em pacman ?c1))
            (criatura-em pacman ?baixo-de-c1)
            (not (turno-ativado))
            
            (forall (?outra-celula1 ?outra-celula2 - celula) 
                (and 
                    ; Movimento do verde
                    (when 
                        (and 
                            (baixo ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-verde ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-verde ?outra-celula1))
                            (criatura-em fantasma-verde ?outra-celula2)
                        )
                    ) 
                    
                    ; Movimento do azul
                    (when 
                        (and 
                            (cima ?outra-celula1 ?outra-celula2)
                            (criatura-em fantasma-azul ?outra-celula1)
                        )
                        (and
                            (not (criatura-em fantasma-azul ?outra-celula1))
                            (criatura-em fantasma-azul ?outra-celula2)
                        )
                    )
                )
            )
        )
    )
)