section .text
extern _malloc
extern _ft_strlen
extern _ft_strcpy
global _ft_strdup

_ft_strdup:
    mov rdi, rdi                ; Charger l'adresse de la chaîne source (s) dans rdi
    call _ft_strlen              ; Appelle `ft_strlen` pour obtenir la longueur de la chaîne
    mov rcx, rax                ; Stocke la longueur dans rcx
    inc rcx                     ; Ajoute 1 pour le caractère nul
    mov rdi, rcx                ; Charger la taille dans rdi pour `malloc`
    call _malloc                 ; Appelle `malloc` pour allouer la mémoire
    test rax, rax               ; Vérifie si l'allocation a réussi
    je end_strdup               ; Si non, retourne 0

    ; Sauvegarder l'adresse source avant d'appeler strcpy
    mov rdx, rsi                ; Sauvegarder l'adresse de la chaîne source dans rdx
    mov rsi, rdx                ; Remettre l'adresse source dans rsi
    mov rdi, rax                ; Charger l'adresse du buffer alloué dans rdi (destination)
    call _ft_strcpy              ; Appelle `ft_strcpy` pour copier la chaîne source dans la destination
end_strdup:
    ret                         ; Retourne le pointeur de la copie
