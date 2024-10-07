.section .text
.global ft_strdup
.extern malloc
.extern ft_strlen

ft_strdup:
    # Appel à ft_strlen pour obtenir la longueur de la chaîne
    movq %rdi, %rsi          # Copie l'adresse de la chaîne dans rsi pour strlen
    call ft_strlen            # Appel de ft_strlen, résultat dans rax (longueur)

    addq $1, %rax             # Ajoute 1 pour le caractère nul de fin
    movq %rax, %rdi           # Prépare la taille pour malloc dans rdi
    call malloc               # Appel de malloc, adresse allouée dans rax

    testq %rax, %rax          # Vérifie si malloc a réussi
    je end_strdup             # Si échec, saute à end_strdup

    movq %rax, %rcx           # Sauvegarde l'adresse allouée dans rcx
    movq %rsi, %rdi           # Prépare les registres pour ft_strcpy
copy_loop:
    movb (%rsi), %al          # Charge le byte de la source dans al
    movb %al, (%rcx)          # Copie le byte dans la destination
    inc %rsi                  # Incrémente l'adresse source
    inc %rcx                  # Incrémente l'adresse destination
    testb %al, %al            # Vérifie si c'est le caractère nul
    jne copy_loop             # Boucle tant que ce n'est pas nul

end_strdup:
    movq %rax, %rdi           # Met l'adresse allouée dans rdi pour le retour
    ret                       # Retour
