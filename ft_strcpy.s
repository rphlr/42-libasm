.section .text
.global ft_strcpy

ft_strcpy:
    movq %rdi, %rsi         # Charge l'adresse de destination dans rdi
    movq %rsi, %rdx         # Charge l'adresse source dans rsi
loop_strcpy:
    movb (%rsi), %al        # Charge le byte de l'adresse source dans al
    movb %al, (%rdi)        # Copie le byte de al dans l'adresse destination
    inc %rdi                # Incrémente la destination
    inc %rsi                # Incrémente la source
    testb %al, %al          # Vérifie si le byte copié est zéro
    jne loop_strcpy         # Continue tant que ce n'est pas zéro
    ret                     # Retourne
