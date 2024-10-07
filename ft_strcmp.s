.section .text
.global ft_strcmp

ft_strcmp:
    movq %rdi, %rcx           # Charger l'adresse de s1 dans rcx
    movq %rsi, %rdx           # Charger l'adresse de s2 dans rdx
loop_strcmp:
    movb (%rcx), %al          # Charger le byte de s1 dans al
    movb (%rdx), %bl          # Charger le byte de s2 dans bl
    cmpb %bl, %al             # Comparer les bytes de s1 et s2
    jne not_equal             # Si différent, sauter à not_equal
    testb %al, %al            # Vérifier si on a atteint la fin de chaîne
    je equal                  # Si oui, les chaînes sont égales
    inc %rcx                  # Incrémenter l'adresse de s1
    inc %rdx                  # Incrémenter l'adresse de s2
    jmp loop_strcmp           # Boucler pour le prochain byte

not_equal:
    subb %bl, %al             # Calculer la différence entre les bytes
    movsx %al, %eax           # Étendre en 32 bits avec signe dans eax
    ret                       # Retourner la différence

equal:
    xorl %eax, %eax           # Retourner 0 pour indiquer égalité
    ret
