.section .text
.global ft_strlen

ft_strlen:
    xor %eax, %eax        # Initialise le compteur de longueur
    mov %rdi, %rcx        # Adresse de la chaîne dans rcx

loop_start:
    cmpb $0, (%rcx)       # Compare le byte à l'adresse rcx avec 0
    je loop_end           # Si zéro, saute à loop_end

    inc %eax              # Incrémente le compteur
    inc %rcx              # Passe au byte suivant
    jmp loop_start        # Retourne au début de la boucle

loop_end:
    ret                   # Retourne la longueur dans eax
