(define
        (problem pacman-problem)
        (:domain pacman-domain)
        (:objects 
p_0_0 p_0_1 p_0_2 p_0_3 p_0_4 p_0_5 p_0_6 p_0_7 p_0_8 p_0_9 p_0_10 p_0_11 p_0_12 p_0_13 p_0_14 p_1_0 p_1_1 p_1_2 p_1_3 p_1_4 p_1_5 p_1_6 p_1_7 p_1_8 p_1_9 p_1_10 p_1_11 p_1_12 p_1_13 p_1_14 p_2_0 p_2_1 p_2_2 p_2_3 p_2_4 p_2_5 p_2_6 p_2_7 p_2_8 p_2_9 p_2_10 p_2_11 p_2_12 p_2_13 p_2_14 p_3_0 p_3_1 p_3_2 p_3_3 p_3_4 p_3_5 p_3_6 p_3_7 p_3_8 p_3_9 p_3_10 p_3_11 p_3_12 p_3_13 p_3_14 - celula
 )
        (:init 
(eh-parede p_0_0)
(eh-parede p_0_1)
(eh-parede p_0_2)
(eh-parede p_0_3)
(eh-parede p_0_4)
(eh-parede p_0_5)
(eh-parede p_0_6)
(eh-parede p_0_7)
(eh-parede p_0_8)
(eh-parede p_0_9)
(eh-parede p_0_10)
(eh-parede p_0_11)
(eh-parede p_0_12)
(eh-parede p_0_13)
(eh-parede p_0_14)
(eh-parede p_1_0)
(eh-fruta-azul p_1_1)
(eh-chao p_1_2)
(eh-chao p_1_3)
(eh-chao p_1_4)
(eh-chao p_1_5)
(eh-chao p_1_6)
(eh-chao p_1_7)
(eh-chao p_1_8)
(eh-chao p_1_9)
(eh-chao p_1_10)
(criatura-em pacman p_1_11)
(eh-chao p_1_12)
(eh-chao p_1_13)
(eh-parede p_1_14)
(eh-parede p_2_0)
(eh-chao p_2_1)
(eh-parede p_2_2)
(eh-parede p_2_3)
(eh-parede p_2_4)
(eh-chao p_2_5)
(eh-parede p_2_6)
(eh-parede p_2_7)
(eh-parede p_2_8)
(eh-parede p_2_9)
(eh-parede p_2_10)
(eh-parede p_2_11)
(eh-parede p_2_12)
(criatura-em fantasma-azul p_2_13)
(eh-parede p_2_14)
(eh-parede p_3_0)
(eh-parede p_3_1)
(eh-parede p_3_2)
(eh-parede p_3_3)
(eh-parede p_3_4)
(eh-parede p_3_5)
(eh-parede p_3_6)
(eh-parede p_3_7)
(eh-parede p_3_8)
(eh-parede p_3_9)
(eh-parede p_3_10)
(eh-parede p_3_11)
(eh-parede p_3_12)
(eh-parede p_3_13)
(eh-parede p_3_14)
(morte fantasma-verde)
(morte fantasma-vermelho)
(turno-pacman)
(celula-direita p_0_0 p_0_1)
(celula-direita p_0_1 p_0_2)
(celula-direita p_0_2 p_0_3)
(celula-direita p_0_3 p_0_4)
(celula-direita p_0_4 p_0_5)
(celula-direita p_0_5 p_0_6)
(celula-direita p_0_6 p_0_7)
(celula-direita p_0_7 p_0_8)
(celula-direita p_0_8 p_0_9)
(celula-direita p_0_9 p_0_10)
(celula-direita p_0_10 p_0_11)
(celula-direita p_0_11 p_0_12)
(celula-direita p_0_12 p_0_13)
(celula-direita p_0_13 p_0_14)
(celula-direita p_1_0 p_1_1)
(celula-direita p_1_1 p_1_2)
(celula-direita p_1_2 p_1_3)
(celula-direita p_1_3 p_1_4)
(celula-direita p_1_4 p_1_5)
(celula-direita p_1_5 p_1_6)
(celula-direita p_1_6 p_1_7)
(celula-direita p_1_7 p_1_8)
(celula-direita p_1_8 p_1_9)
(celula-direita p_1_9 p_1_10)
(celula-direita p_1_10 p_1_11)
(celula-direita p_1_11 p_1_12)
(celula-direita p_1_12 p_1_13)
(celula-direita p_1_13 p_1_14)
(celula-direita p_2_0 p_2_1)
(celula-direita p_2_1 p_2_2)
(celula-direita p_2_2 p_2_3)
(celula-direita p_2_3 p_2_4)
(celula-direita p_2_4 p_2_5)
(celula-direita p_2_5 p_2_6)
(celula-direita p_2_6 p_2_7)
(celula-direita p_2_7 p_2_8)
(celula-direita p_2_8 p_2_9)
(celula-direita p_2_9 p_2_10)
(celula-direita p_2_10 p_2_11)
(celula-direita p_2_11 p_2_12)
(celula-direita p_2_12 p_2_13)
(celula-direita p_2_13 p_2_14)
(celula-direita p_3_0 p_3_1)
(celula-direita p_3_1 p_3_2)
(celula-direita p_3_2 p_3_3)
(celula-direita p_3_3 p_3_4)
(celula-direita p_3_4 p_3_5)
(celula-direita p_3_5 p_3_6)
(celula-direita p_3_6 p_3_7)
(celula-direita p_3_7 p_3_8)
(celula-direita p_3_8 p_3_9)
(celula-direita p_3_9 p_3_10)
(celula-direita p_3_10 p_3_11)
(celula-direita p_3_11 p_3_12)
(celula-direita p_3_12 p_3_13)
(celula-direita p_3_13 p_3_14)
(celula-baixo p_0_0 p_1_0)
(celula-baixo p_0_1 p_1_1)
(celula-baixo p_0_2 p_1_2)
(celula-baixo p_0_3 p_1_3)
(celula-baixo p_0_4 p_1_4)
(celula-baixo p_0_5 p_1_5)
(celula-baixo p_0_6 p_1_6)
(celula-baixo p_0_7 p_1_7)
(celula-baixo p_0_8 p_1_8)
(celula-baixo p_0_9 p_1_9)
(celula-baixo p_0_10 p_1_10)
(celula-baixo p_0_11 p_1_11)
(celula-baixo p_0_12 p_1_12)
(celula-baixo p_0_13 p_1_13)
(celula-baixo p_0_14 p_1_14)
(celula-baixo p_1_0 p_2_0)
(celula-baixo p_1_1 p_2_1)
(celula-baixo p_1_2 p_2_2)
(celula-baixo p_1_3 p_2_3)
(celula-baixo p_1_4 p_2_4)
(celula-baixo p_1_5 p_2_5)
(celula-baixo p_1_6 p_2_6)
(celula-baixo p_1_7 p_2_7)
(celula-baixo p_1_8 p_2_8)
(celula-baixo p_1_9 p_2_9)
(celula-baixo p_1_10 p_2_10)
(celula-baixo p_1_11 p_2_11)
(celula-baixo p_1_12 p_2_12)
(celula-baixo p_1_13 p_2_13)
(celula-baixo p_1_14 p_2_14)
(celula-baixo p_2_0 p_3_0)
(celula-baixo p_2_1 p_3_1)
(celula-baixo p_2_2 p_3_2)
(celula-baixo p_2_3 p_3_3)
(celula-baixo p_2_4 p_3_4)
(celula-baixo p_2_5 p_3_5)
(celula-baixo p_2_6 p_3_6)
(celula-baixo p_2_7 p_3_7)
(celula-baixo p_2_8 p_3_8)
(celula-baixo p_2_9 p_3_9)
(celula-baixo p_2_10 p_3_10)
(celula-baixo p_2_11 p_3_11)
(celula-baixo p_2_12 p_3_12)
(celula-baixo p_2_13 p_3_13)
(celula-baixo p_2_14 p_3_14)
(celula-esquerda p_0_1 p_0_0)
(celula-esquerda p_0_2 p_0_1)
(celula-esquerda p_0_3 p_0_2)
(celula-esquerda p_0_4 p_0_3)
(celula-esquerda p_0_5 p_0_4)
(celula-esquerda p_0_6 p_0_5)
(celula-esquerda p_0_7 p_0_6)
(celula-esquerda p_0_8 p_0_7)
(celula-esquerda p_0_9 p_0_8)
(celula-esquerda p_0_10 p_0_9)
(celula-esquerda p_0_11 p_0_10)
(celula-esquerda p_0_12 p_0_11)
(celula-esquerda p_0_13 p_0_12)
(celula-esquerda p_0_14 p_0_13)
(celula-esquerda p_1_1 p_1_0)
(celula-esquerda p_1_2 p_1_1)
(celula-esquerda p_1_3 p_1_2)
(celula-esquerda p_1_4 p_1_3)
(celula-esquerda p_1_5 p_1_4)
(celula-esquerda p_1_6 p_1_5)
(celula-esquerda p_1_7 p_1_6)
(celula-esquerda p_1_8 p_1_7)
(celula-esquerda p_1_9 p_1_8)
(celula-esquerda p_1_10 p_1_9)
(celula-esquerda p_1_11 p_1_10)
(celula-esquerda p_1_12 p_1_11)
(celula-esquerda p_1_13 p_1_12)
(celula-esquerda p_1_14 p_1_13)
(celula-esquerda p_2_1 p_2_0)
(celula-esquerda p_2_2 p_2_1)
(celula-esquerda p_2_3 p_2_2)
(celula-esquerda p_2_4 p_2_3)
(celula-esquerda p_2_5 p_2_4)
(celula-esquerda p_2_6 p_2_5)
(celula-esquerda p_2_7 p_2_6)
(celula-esquerda p_2_8 p_2_7)
(celula-esquerda p_2_9 p_2_8)
(celula-esquerda p_2_10 p_2_9)
(celula-esquerda p_2_11 p_2_10)
(celula-esquerda p_2_12 p_2_11)
(celula-esquerda p_2_13 p_2_12)
(celula-esquerda p_2_14 p_2_13)
(celula-esquerda p_3_1 p_3_0)
(celula-esquerda p_3_2 p_3_1)
(celula-esquerda p_3_3 p_3_2)
(celula-esquerda p_3_4 p_3_3)
(celula-esquerda p_3_5 p_3_4)
(celula-esquerda p_3_6 p_3_5)
(celula-esquerda p_3_7 p_3_6)
(celula-esquerda p_3_8 p_3_7)
(celula-esquerda p_3_9 p_3_8)
(celula-esquerda p_3_10 p_3_9)
(celula-esquerda p_3_11 p_3_10)
(celula-esquerda p_3_12 p_3_11)
(celula-esquerda p_3_13 p_3_12)
(celula-esquerda p_3_14 p_3_13)
(celula-cima p_1_0 p_0_0)
(celula-cima p_1_1 p_0_1)
(celula-cima p_1_2 p_0_2)
(celula-cima p_1_3 p_0_3)
(celula-cima p_1_4 p_0_4)
(celula-cima p_1_5 p_0_5)
(celula-cima p_1_6 p_0_6)
(celula-cima p_1_7 p_0_7)
(celula-cima p_1_8 p_0_8)
(celula-cima p_1_9 p_0_9)
(celula-cima p_1_10 p_0_10)
(celula-cima p_1_11 p_0_11)
(celula-cima p_1_12 p_0_12)
(celula-cima p_1_13 p_0_13)
(celula-cima p_1_14 p_0_14)
(celula-cima p_2_0 p_1_0)
(celula-cima p_2_1 p_1_1)
(celula-cima p_2_2 p_1_2)
(celula-cima p_2_3 p_1_3)
(celula-cima p_2_4 p_1_4)
(celula-cima p_2_5 p_1_5)
(celula-cima p_2_6 p_1_6)
(celula-cima p_2_7 p_1_7)
(celula-cima p_2_8 p_1_8)
(celula-cima p_2_9 p_1_9)
(celula-cima p_2_10 p_1_10)
(celula-cima p_2_11 p_1_11)
(celula-cima p_2_12 p_1_12)
(celula-cima p_2_13 p_1_13)
(celula-cima p_2_14 p_1_14)
(celula-cima p_3_0 p_2_0)
(celula-cima p_3_1 p_2_1)
(celula-cima p_3_2 p_2_2)
(celula-cima p_3_3 p_2_3)
(celula-cima p_3_4 p_2_4)
(celula-cima p_3_5 p_2_5)
(celula-cima p_3_6 p_2_6)
(celula-cima p_3_7 p_2_7)
(celula-cima p_3_8 p_2_8)
(celula-cima p_3_9 p_2_9)
(celula-cima p_3_10 p_2_10)
(celula-cima p_3_11 p_2_11)
(celula-cima p_3_12 p_2_12)
(celula-cima p_3_13 p_2_13)
(celula-cima p_3_14 p_2_14)
 )
        (:goal (and 
(morte fantasma-azul)
(morte fantasma-verde)
(morte fantasma-vermelho)
 )))