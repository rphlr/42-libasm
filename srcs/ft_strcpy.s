section .text
global _ft_strcpy

_ft_strcpy:
    mov rcx, rdi            ; rcx reçoit l'adresse de destination (s1)
    mov rdx, rsi            ; rdx reçoit l'adresse de source (s2)
copy_loop:
    mov al, byte [rdx]      ; Charger le byte de s2 dans al
    mov byte [rcx], al      ; Copier al dans l'adresse de s1
    test al, al             ; Vérifie si c'est le caractère nul
    je done                 ; Si oui, fin de copie
    inc rcx                 ; Avance dans s1
    inc rdx                 ; Avance dans s2
    jmp copy_loop           ; Continue la copie
done:
    mov rax, rdi            ; Place l'adresse de destination (s1) dans rax pour le retour
    ret                     ; Retourne l'adresse de destination
