section .text
global _ft_strlen

_ft_strlen:
    mov rcx, rdi            ; rcx reçoit l'adresse de la chaîne (s)
    xor rax, rax            ; Initialise rax (compteur) à 0
loop_strlen:
    cmp byte [rcx + rax], 0 ; Vérifie si le caractère actuel est nul
    je end_strlen           ; Si nul, on sort de la boucle
    inc rax                 ; Incrémente le compteur
    jmp loop_strlen         ; Boucle pour le prochain caractère
end_strlen:
    ret                     ; Retourne la longueur de la chaîne (dans rax)
